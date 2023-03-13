Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343CA6B71C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCMI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826B4205
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678697543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rn0ZDN/u4ONTQp/tmI2ypE9T4TH7mmvAAf+chBeDHxQ=;
        b=iTZgLC0/P4qi6wVW3VTOgc+neK97LwiLu3UNCvQ123EAUoBWPfrfR0fo/j9GFy2jwOWGWK
        boMb7HkDvZI7jHO2z5g5+uUfHp80tGs6CojbGf1KxkT37026QmVvDGU0lnGi3Ls4iZPUnl
        D7WS0FTqzCucz6zpTpB298Sx1oNGOg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-j-eQXjg8ORK0ti-wx5PCJA-1; Mon, 13 Mar 2023 04:52:21 -0400
X-MC-Unique: j-eQXjg8ORK0ti-wx5PCJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71414800050;
        Mon, 13 Mar 2023 08:52:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3214D202701E;
        Mon, 13 Mar 2023 08:52:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 191791801CF6; Mon, 13 Mar 2023 09:52:20 +0100 (CET)
Date:   Mon, 13 Mar 2023 09:52:20 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Christian Hergert <chergert@redhat.com>,
        Albert Esteve <aesteve@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] drm/virtio: Enable fb damage clips property for the
 primary plane
Message-ID: <20230313085220.fwvcul7sz7ycxtm4@sirius.home.kraxel.org>
References: <20230310125943.912514-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125943.912514-1-javierm@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 01:59:42PM +0100, Javier Martinez Canillas wrote:
> Christian Hergert reports that the driver doesn't enable the property and
> that leads to always doing a full plane update, even when the driver does
> support damage clipping for the primary plane.
> 
> Don't enable it for the cursor plane, because its .atomic_update callback
> doesn't handle damage clips.
> 
> Reported-by: Christian Hergert <chergert@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

