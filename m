Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36495FB7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJKPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiJKPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E41D0C6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665503493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeMqmm6RZi8nEiwf9Am5Lyu5xHfrJbfXudXrmpg8EVU=;
        b=HvTzOzSSc2ZWQvodjD0CSkJYwP9cm1bQEs0CdHDVI6uBaMweR0gGNCC7fNTgwBBwC6Yc9z
        XoAAyTekc6QGpdFDQTOwx+wihjDNQKy+yKV35DgBP+LebkC6cbEc0dnuDCz/bb2DTXkBwr
        7MPv9tccWrSdYvFWcxjl2tJk/AV01Qc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-4AWxnL_hM_KSqEyq14Hs5w-1; Tue, 11 Oct 2022 11:51:32 -0400
X-MC-Unique: 4AWxnL_hM_KSqEyq14Hs5w-1
Received: by mail-wm1-f70.google.com with SMTP id k2-20020a05600c1c8200b003c3dd3aa638so6159325wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeMqmm6RZi8nEiwf9Am5Lyu5xHfrJbfXudXrmpg8EVU=;
        b=KkPm5LXV7fgWVY0+UAkudrwAk68ffw7K8cKwozOud0OZikhu3KQS2nj893iOwI8Wsr
         GUu9Z/bBwlsbjkB/TZyr7/X0iVHr013JEfc6N7jc+krnUTjs3y6DnTXJBT/88GX2fIjT
         dqTobFkfvyHunUl4GkLAcZsDEM0rog7SIIsLgUUa0FLc5sA+0T1tBD/hHxcHQiv6t2oG
         UADvwrnuPZcXh+WVLqo65DYYh+FiGYpoV/SBMVFR3uJCC8+jlsixc2zXK7hsv8AmyQ1V
         1Xq3XoE5GuqAG/y/iv9WXhJgS+R1fzStsuG5uRIn/ze2aPmp8cDLktdfZ0HOPj27nlTc
         BUlQ==
X-Gm-Message-State: ACrzQf3KxMzNxFwsl0mlgOLCJ538Fc5ahjprYc4duDYWuqOMA0tfGxLe
        aVPptaYwSa5NMl117Gt9oXJFrrXTtt7QG2qkSO4Hx/sYfUXhkoKhnZzlzO3L+cBujDrh9TQoWX3
        9TXi3IFlGXCgt+3lTfcZv8i4=
X-Received: by 2002:adf:dec3:0:b0:22e:6efe:7861 with SMTP id i3-20020adfdec3000000b0022e6efe7861mr15840534wrn.454.1665503490701;
        Tue, 11 Oct 2022 08:51:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sB9t5u06LkupTlbVy8ECDTcOLBS1O5d6P3Qmwe1/vtkKfuRgNig3wn4YTbJ9AGejvjbghHQ==
X-Received: by 2002:adf:dec3:0:b0:22e:6efe:7861 with SMTP id i3-20020adfdec3000000b0022e6efe7861mr15840520wrn.454.1665503490490;
        Tue, 11 Oct 2022 08:51:30 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id az29-20020a05600c601d00b003c6b70a4d69sm5485564wmb.42.2022.10.11.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:51:29 -0700 (PDT)
Date:   Tue, 11 Oct 2022 16:51:28 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unloaded tainted modules list with tcrypt
Message-ID: <20221011155128.k27rsgevfwyawvbh@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB184240ECFBB251B8A9CC1B8EAB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW5PR84MB184240ECFBB251B8A9CC1B8EAB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-10-11 00:09 +0000, Elliott, Robert (Servers) wrote:
> Changing to == seems to work well - that shows incremented counts
> rather than new entries:
> Unloaded tainted modules: tcrypt():40 padlock_aes():1 isst_if_mbox_msr():56 pcc_cpufreq():56 acpi_cpufreq():112

Hi Elliott,

Please note, any module that does not carry a taint should _not_
be on the aforementioned list. See the following which is already
in Linus' tree:

commit 47cc75aa92837a9d3f15157d6272ff285585d75d
Author: Aaron Tomlin <atomlin@redhat.com>
Date:   Fri Oct 7 14:38:12 2022 +0100

    module: tracking: Keep a record of tainted unloaded modules only
    
    This ensures that no module record/or entry is added to the
    unloaded_tainted_modules list if it does not carry a taint.
    
    Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
    Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
    Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
    Acked-by: Luis Chamberlain <mcgrof@kernel.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index a139e63b6f20..26d812e07615 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -22,6 +22,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&


-- 
Aaron Tomlin

