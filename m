Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95496E19F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNCEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDNCET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:04:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FF3C3A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:04:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m18so16941039plx.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681437857; x=1684029857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSeMJSB+1OwVk7zbF+vhVDfhbKvf9MjEEZ5KVFwlsd8=;
        b=GbNAMYG0e+ZTkBi0pfWkHDO2l22kbpu5C/Hh+zyMkkdZ7fveDWmRSPP4srC3DLdxt7
         7SKCX6KbgwuJJph0WxS1Kvwgr4ANRWNCw16my/6B/dG2y4KtOlk+ivf1Eczug1JOKlCC
         tua8eu4/V33cYHxN4TJQM3AAjAWTDx7SvZgqfNF1zgaCaC1msnVn3G/UNdtjlOodnTlH
         b27AltOSoVwxtlEpHcUvU80pAPyPFqQO/G/epj7Tr99nUe/rwf+ah1uIAcD/3zaFXRoQ
         fc142BQ/ynQfpwvmPBxVuhxRixH8lwPhjoYlqpyI118LS7MbrkdYx3ZYi73iJNTlcmNz
         Yf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681437857; x=1684029857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSeMJSB+1OwVk7zbF+vhVDfhbKvf9MjEEZ5KVFwlsd8=;
        b=NU9B6TVZ1/tPGQkQxSxWAVgV56UVCxtD+hOF4PssfolGqBBbN+ao1HaoxSYeqoJ2RN
         9V1tuthvv3XayWotCCGiOCzT//KLCEgOLIZ8CXW8WpBgtuXxk+FzHHVO1zZtIXa3jS02
         DZIxvzGMD/lzH/7aDv7sPZeIAXXelA+EOpsDvyiGa2qi4KP4It2O2DvchzvBt/dZmxDY
         smDqTsu9cBVVCqVYmgOqvCT2Tb6F7aswFSyxkO0nhvwa6ZtuEmGSOtqedk6EMg97lfRw
         bgkwdWFrgAve6s2LEiuFnY3smG0jJ1nAxlul8OOoHP1C0IoEnvd6uH9Bckzw7faRx1Qd
         VsDg==
X-Gm-Message-State: AAQBX9dN0/mkx/kF7GDuctfyDaA24i/a/TcThil91tZ3IkXGSmIcQKI5
        EBfmLcZMgKtODgtQfy2vgCYNqGmeo5w=
X-Google-Smtp-Source: AKy350aOhc4mA5KYzyXboebEAY7znLoio0fCpKQ4kpxPsM+7QpzUr0wlUp4+aDQmNrV4QCWoZrYJWg==
X-Received: by 2002:a17:90b:3a91:b0:23f:7d05:8762 with SMTP id om17-20020a17090b3a9100b0023f7d058762mr3592951pjb.23.1681437857632;
        Thu, 13 Apr 2023 19:04:17 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b002470ce35621sm1927374pjs.20.2023.04.13.19.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Apr 2023 19:04:17 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:11:26 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH v2] erofs: get rid of z_erofs_fill_inode()
Message-ID: <20230414101126.00005a93.zbestahu@gmail.com>
In-Reply-To: <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
References: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
        <20230413092241.73829-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 17:22:41 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Prior to big pclusters, non-compact compression indexes could have
> empty headers.
> 
> Let's just avoid the legacy path since it can be handled properly
> as a specific compression header with z_erofs_fill_inode_lazy() too.
> 
> Tested with erofs-utils exist versions.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

