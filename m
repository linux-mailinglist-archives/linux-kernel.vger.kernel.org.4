Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256CF70277F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjEOIqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEOIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4A2C9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684140347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzdTTm54ffhyFjajMYLOi/MjjYQueX7ItYGaiPJCBpg=;
        b=XDHnqOjvgphqS2C+dIiF91PEtCj/xQG7NIZlAqusy+9akWwLjKYoYiORC+gYAWEKt4f78h
        DKzJ0fy+4/MqfUWY5aZumUAy9zfT2A7SC+6RQVd3kvfUEbwnPtDUUSb21lrydg3Fy/Aq/a
        CUIu9iTozpGTiuC5oV94t4NCZS5+eso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-GrXF1C4eMKagw6RDus72XQ-1; Mon, 15 May 2023 04:45:44 -0400
X-MC-Unique: GrXF1C4eMKagw6RDus72XQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8D62802A95;
        Mon, 15 May 2023 08:45:43 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A84BC63F5F;
        Mon, 15 May 2023 08:45:39 +0000 (UTC)
Date:   Mon, 15 May 2023 16:45:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, louhongxiang@huawei.com
Subject: Re: [PATCH 1/2] Revert "scsi: core: Do not increase scsi_device's
 iorequest_cnt if dispatch failed"
Message-ID: <ZGHxLixW2rR34S+e@ovpn-8-26.pek2.redhat.com>
References: <20230515070156.1790181-1-haowenchao2@huawei.com>
 <20230515070156.1790181-2-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515070156.1790181-2-haowenchao2@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:01:55PM +0800, Wenchao Hao wrote:
> the "atomic_inc(&cmd->device->iorequest_cnt)" in scsi_queue_rq() would
> causes kernel panic, because cmd->device may be freed after returning
> from scsi_dispatch_cmd().
> 
> This reverts commit cfee29ffb45b1c9798011b19d454637d1b0fe87d.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Closes:https://lore.kernel.org/linux-scsi/8e0f2d31-e6ff-ec4a-3974-450560ad49c5@huawei.com/T/#t

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

