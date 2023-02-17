Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D4669B2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBQTRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBQTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:17:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8C3253C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:17:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 14so2379128pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9Uxy7nFDuIOFCoJagqMz6xxnttnPJ/OHPVteGw8GOE=;
        b=g573LeO1oi+0LwpT3XYSPhifAWhQaLQsxM4/+PIlGJpGTA4KA8nzUGkZji4TJPMtnz
         ODo4wXr27Uhx5P98iCoGS3Ym4AViXXuWjgCht8xF1Thm+z+7L7TTuo1OFT4azV3BAloG
         H1PasdewhlnZiAf9fkd4B7o6HmLmTQXJeBlFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9Uxy7nFDuIOFCoJagqMz6xxnttnPJ/OHPVteGw8GOE=;
        b=xVOwgkV+1NKctPrthuc/7fmxeFkbhIasMrk2r8BTqdddi19iOYGVpE6WxslswmhOqo
         rv5FPXIMMqEAWfpJQMb97L3fLDVSSnK5c8o22FbEwzLlVOTbrw5i3CM8v6q+g382ok34
         tAlG78ZhVcPWFdHzEruH3oS2v8bA2H2hX0zxolEdr9Gxf4jaH04aArdqw4r/4xE8PE2A
         eygFYcOPTz3RpCmqNVp9WLRdiSOBUJJQUJspg4Ma6VFsJttQuZ8daT+mhZFen+68/q7+
         H1yq5u1SCH1VoVs0UQ+RPVsbZuhHg3kcHY70FGskFx+iiROwHcvhsU31h1q2cRkVM6fW
         3B0Q==
X-Gm-Message-State: AO0yUKUHwcYUUwG9cdZZmYR7Kx6Fbl75xl+BLsvhlqU370+pW3LEPYnK
        SVpwJHBblNbh57vZQOBGmN5HZw==
X-Google-Smtp-Source: AK7set+TNLdsFi+GIF00qvaZHvN/MV0UnaVuTstdiAycTsRUkMMjdE6XQKGef4CI3Z2uWKXw3USzlQ==
X-Received: by 2002:a17:903:2450:b0:19a:d453:4ac with SMTP id l16-20020a170903245000b0019ad45304acmr1835458pls.61.1676661463909;
        Fri, 17 Feb 2023 11:17:43 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b00192d9b86318sm3458474plb.137.2023.02.17.11.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:17:42 -0800 (PST)
Message-ID: <63efd2d6.170a0220.c7721.6d38@mx.google.com>
X-Google-Original-Message-ID: <202302171116.@keescook>
Date:   Fri, 17 Feb 2023 11:17:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp update for v6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny seccomp update for v6.3-rc1. In the future, I may
collapse these kinds of tiny changes into my larger kernel hardening tree,
but figured I wouldn't do it this time without a heads-up. :)

Thanks!

-Kees

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.3-rc1

for you to fetch changes up to 0fb0624b15d21622c214617fda5c05a203b04564:

  seccomp: fix kernel-doc function name warning (2023-01-13 17:01:06 -0800)

----------------------------------------------------------------
seccomp update for v6.3-rc1

- Fix kernel-doc function name ordering to avoid warning (Randy Dunlap)

----------------------------------------------------------------
Randy Dunlap (1):
      seccomp: fix kernel-doc function name warning

 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
