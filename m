Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8F64CFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiLNS5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiLNS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:57:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06929818
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:57:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d15so4317998pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bY4VEdYs09hOzthd1Z+2Tg7r4Tbo4YmFAJOoaFTn17c=;
        b=FklpDs8fcpm7PuPvm+DIW8s8Mu1INMI3r3Mwf8bm9wHhQTP+qEgSNFav+w78cRsGM/
         +b5e9/NTeDhNDRCKWpYnboKRU9VK8VtgTAlZK/DPHTbgD+PG67wSt4bvDbBMqpvPJdqj
         ZANhfPNwgJ7LUN38x2hgefNGhOyQ4/kS3MbXA2Ey3i2+RAmCv3YSLAVFmN+oHGu/9RSJ
         DVllKTqCNa+GEci9qccy1uNAR8BAajSvIDjKilY1CChb5DCJaN2gkq82GXuO2zKGaZXE
         U9SthnWDXd9t0tRvQhM2LTcbxXR7t+MyhQhpscHryFPQoQapXCl7NvDTjjNKqQiK++C5
         DYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY4VEdYs09hOzthd1Z+2Tg7r4Tbo4YmFAJOoaFTn17c=;
        b=GJwmjVPOnxHWaD9GZBoDKrLeCZfbOOJ8f4j/IFU/SaZJbqPAl6X8Rg7sgC54F2l0Fu
         VLzQVmZAW2hRP388/VDN/L0OUCe7mixGTUnmoCOhu3kzRp0SpCFGbcWC7egIIjbo2nGa
         tY/EXeKWR6qjKk2xO9tEhz81KfwSsciqGWMF2QuxaDkdbgklLDpeT4vCEe5AxHSmQ3GW
         mODzSsjaU8j9fjlHwF7VYFSXUMbbRRdEyEfv1C9arZA7Yg9F/zRKgcfujOTneOmR1PSk
         IZvOSfNvdpvl3o96id/eQLUigqaEfziaU8EwRcYBUvDvD+xxFSWbc3E3m9BuTPdDVzQw
         YnHw==
X-Gm-Message-State: ANoB5plqq7xTnhcQwrUZPgcgSOn+GkcThOGOXeVgVJbb7Lt4+R6QXyqB
        bQATZU86iKlSAZvVHKfzskjNvSHat6ZJeCQ4cuI=
X-Google-Smtp-Source: AA0mqf79hVPrsbABzf25C4mtc4KPu3w2AA2+7Dd1gjqnnyenwOtv2JQQ+oFTh00Se/IRETyiRgiJEw==
X-Received: by 2002:a17:902:a70b:b0:187:ede:e014 with SMTP id w11-20020a170902a70b00b001870edee014mr25167368plq.44.1671044223953;
        Wed, 14 Dec 2022 10:57:03 -0800 (PST)
Received: from google.com ([2620:15c:2d1:203:b5a0:270f:31ca:3995])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b00179e1f08634sm2188913plg.222.2022.12.14.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:57:03 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:56:58 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v2] scripts/gdb: Ensure the absolute path is generated on
 initial source
Message-ID: <20221214185658.fgsqrysq4luk2w4n@google.com>
References: <20220712110248.1404125-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712110248.1404125-1-atomlin@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:02:48PM +0100, Aaron Tomlin wrote:
> Post 'make scripts_gdb' a symbolic link to scripts/gdb/vmlinux-gdb.py
> is created. Currently 'os.path.dirname(__file__)' does not generate
> the absolute path to scripts/gdb resulting in the following:
> 
>     (gdb) source vmlinux-gdb.py
>     Traceback (most recent call last):
>       File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
> 	import linux.utils
>     ModuleNotFoundError: No module named 'linux'

So I recently moved to a new machine, and lost my previous .gdbinit.

I've re-added:
add-auto-load-safe-path /path/to/linux/

to my new ~/.gdbinit.

Upon startup, lx-dmesg and friends aren't available.

If I try:
(gdb) source scripts/gdb/vmlinux-gdb.py
Traceback (most recent call last):
  File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
    import linux.utils
ModuleNotFoundError: No module named 'linux'

Which is exactly the error claimed to be fixed by
commit b99695580bfc ("scripts/gdb: ensure the absolute path is generated on initial source")
even though I have b99695580bfc, which is how I found this thread to
reply to.

(gdb) show auto-load safe-path
List of directories from which it is safe to auto-load files is $debugdir:$datadir/auto-load:/path/to/linux/.

$ gdb-multiarch --version | head -n1
GNU gdb (Debian 12.1-3) 12.1
$ python3 --version
Python 3.10.8

I've also RTFM @
Documentation/dev-tools/gdb-kernel-debugging.rst
though perhaps there's something I've missed?

$ grep -rn GDB_SCRIPTS .config
4162:CONFIG_GDB_SCRIPTS=y

This definitely has worked in the past for me, on my previous
workstation.

(gdb) show configuration
...
	     --with-python=/usr (relocatable)
	     --with-python-libdir=/usr/lib (relocatable)
...
(gdb) apropos lx
(gdb)

No warnings from GDB either about the autoload path not being set.
Running gdb in my top level kernel sources.

Am I holding it wrong?

Any tips on how to go about debugging this?

> 
> This patch ensures that the absolute path to scripts/gdb in relation to
> the given file is generated so each module can be located accordingly.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  scripts/gdb/vmlinux-gdb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index 4136dc2c59df..3e8d3669f0ce 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -13,7 +13,7 @@
>  
>  import os
>  
> -sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
> +sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/scripts/gdb")
>  
>  try:
>      gdb.parse_and_eval("0")
> -- 
> 2.34.3
> 
> 
