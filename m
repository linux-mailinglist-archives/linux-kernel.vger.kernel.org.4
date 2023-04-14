Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A06E1FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDNJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDNJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D25B80
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681465807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyikU5M9d76wbxiGEiGM6t7sb6u7giUEixuT9mv0t1Y=;
        b=JMn/U+0r8SIJLM7TFaVBtFUo+ya1hpVxotVVXo2wVr3oPAJT9JuWp+4kZea2XXNpDOVM6G
        7cvSZqHSchSs+uTaOaBGx0N+RCCTEIWQElm1hrm+zDJdybah9HgWEc5AkMk6zRZ9fwB2js
        PuDX4LuDPuHmbk07cUowXMN5CnpV3K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-XS39Y3QeNJW4OlVc1qG7KQ-1; Fri, 14 Apr 2023 05:50:02 -0400
X-MC-Unique: XS39Y3QeNJW4OlVc1qG7KQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 810C6185A7A8;
        Fri, 14 Apr 2023 09:50:01 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF76A2027043;
        Fri, 14 Apr 2023 09:50:00 +0000 (UTC)
Date:   Fri, 14 Apr 2023 17:49:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZDkhxGzMOvmrt1PI@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv>
 <ZDabRr/yyakrrDDO@arm.com>
 <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv>
 <ZDgSCfLMtL9heS8J@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDgSCfLMtL9heS8J@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/23 at 03:30pm, Catalin Marinas wrote:
> On Thu, Apr 13, 2023 at 03:45:50PM +0800, Baoquan He wrote:
> > I am OK with this version, or the version with min(SZ_4G,
> > arm64_dma_phys_limit), or v4. Please help point out if I got your idea
> > correctly. Thanks a lot.
> 
> I think we should stick to this patch. The disabling of the ZONE_DMA(32)
> is fairly specialised and you are right that we should not introduce an
> artificial 4GB crashkernel boundary on such systems. The slight
> confusion may be that ,high triggers a search above 4GB where there's
> not such boundary but this would match the documentation anyway.

OK, sounds good to me. Thanks a lot for all those careful reviewing and
helpful suggestions.

