Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEEE72FED8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbjFNMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbjFNMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63E101
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686746230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iALzGBdIRz3HoCIqpIVxwdpEjosaJBnZn2PpBfVlcPs=;
        b=WALwuvzgvkH5iS2yngLzqTo73ridoDrxR4/MZcaASUJ/865rCGEpmnfK3V3gYQeyDXIl5k
        DQjWpHDbQ48iQgdyd25DxOBp9xJjXcPl5YL+ozXenfADHnYMv0USVJJhD7sC0qaLcATzwQ
        VyaZMmR+SGUCjFt/W0Qbl0BqK5dchko=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-TkOiNhRgMpGVmQLfHcKinQ-1; Wed, 14 Jun 2023 08:37:08 -0400
X-MC-Unique: TkOiNhRgMpGVmQLfHcKinQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75ec325d255so89464085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746228; x=1689338228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iALzGBdIRz3HoCIqpIVxwdpEjosaJBnZn2PpBfVlcPs=;
        b=FU1R7jZJP3OYh6c06+LwZoinYyuDzSVZgT4DTTihvdKILj5Sp6K2sNS+hHwrby9GV+
         yh6FeiTfyGmZKISRlT8gjHG6FROM/tqtg7xpZVMYKRxg/7Twjs93SUf++r3hz0hob0sn
         uXeFPvxR1On3NsmM+CU/Z+YuaqWUeLNqPWrVUid+Gl1qVDpp99zBAXQj4Dv1OpOF39MX
         cSsfBwh6TrI+P5y0W5qeN9QBiAmwJI2T+FnQL5Sx7KfLf60Kye+Nj7yQ2bMy/qQO+66D
         M8V48+eTmAyOMwtlWk5aOVJze/nWLlr+iA7DtZcY0gAd0i1200M7QlI7InEKPUKoyLXT
         +HZA==
X-Gm-Message-State: AC+VfDzzZwxycD4ZsSnf+Jbsk+tv+eAemPXxDQh6sSZTxKbenbKcd4m4
        hdV+YeuxgJKonbfl3WCTMBgMh8RNCV9FOeuPD29qT/itUTy5ZlHH86FKC3fXqaMOjnvP4ESkgkU
        2MDjIrMXeExEV2IHHmIAfxHjN
X-Received: by 2002:a05:620a:6413:b0:75b:23a1:82a3 with SMTP id pz19-20020a05620a641300b0075b23a182a3mr15368424qkn.4.1686746228056;
        Wed, 14 Jun 2023 05:37:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MRLSiFBvqUntXv9WHfkAu4IjQ4TXsWgICsiEBUkXRkiRwo+PL31bLP4+yQAl16dnAl7/3UQ==
X-Received: by 2002:a05:620a:6413:b0:75b:23a1:82a3 with SMTP id pz19-20020a05620a641300b0075b23a182a3mr15368413qkn.4.1686746227833;
        Wed, 14 Jun 2023 05:37:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id x24-20020a05620a12b800b0075d031ba684sm2580258qki.99.2023.06.14.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:37:07 -0700 (PDT)
Date:   Wed, 14 Jun 2023 08:37:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     wuyonggang001@208suo.com
Cc:     viro@zeniv.linux.org.uk, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha/mm: Fix comparing pointer
Message-ID: <ZIm0cu1FdlKo5ww0@x1n>
References: <20230614065602.29731-1-zhanglibing@cdjrlc.com>
 <258e87a54a1dd59b4f3d62ba9fa42242@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <258e87a54a1dd59b4f3d62ba9fa42242@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 02:59:20PM +0800, wuyonggang001@208suo.com wrote:
> Fix the following coccicheck warning:
> 
> arch/alpha/mm/fault.c:200:52-53: WARNING comparing pointer to 0
> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

