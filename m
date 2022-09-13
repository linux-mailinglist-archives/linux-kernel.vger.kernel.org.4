Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4695B7A44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiIMS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiIMSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:55:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29C2BE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:44:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z21so18929417edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dThWzCSl3rClX1d2mp5SRRWeMi6n531lA3pM/MaaT4U=;
        b=NO6F49ERremB/no797ypCT+oPpcxjRLwPvX3x0Pxn4MtJzEr1u/mC1GjFVU0fYhfyo
         wCw1qkp22abhpxGCBAKHxbHZXDuSRxJOEGB6hRrTHKyk+VlBlcuDz6QF6x1gX0eXkSxC
         BaQRnwqbj0ImYdlTLfjMDCyVc9eQ3DP9QlSk/p3+Mo0RC6+J4dVawRaupcloNmZI5Anw
         IUvZbvi9dS28T15FSFpTCsywXjwtslfqqzgBP7ghJ10rOQqpFOBk+oUSYgvBxVYKdorK
         BDsuIwtvuYmGB9lhpJxDfdhIHZqfHV8aOqjQSqG3dwfZXB2onEErT6r0e0OmTZDOfog4
         a02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dThWzCSl3rClX1d2mp5SRRWeMi6n531lA3pM/MaaT4U=;
        b=rrlEUnJQGAvqJ9hEttc58u/5mdXNgmFdmOUGpQhB6smIkrkIstz+CR+o3+wE2YYxTs
         hqgP5S4kBgVdzeYqjtS3ubt75IqhuSAYRcEy4dTRe4YpkBPFjlDsb8oamQMZg1aGHEup
         I579uEAEgAVHObx0NitJouJbbYS0a9U2ZJz8avuKF1vBQYkVb14AmuP/SMR2Bw+7gt8m
         RmR77FFc1g7AO0LBv1TPtA4n5S9mBBRDnQagOERmyFh8KfEdp/erohQJ70VRH4zCWXNJ
         q31kZgXYZi5CwI3psJ+foOQZfJIcwcUN/LKAnmK73fM/uaeK7/eyJA2SZvtMaWhKkKBK
         lLbw==
X-Gm-Message-State: ACgBeo3WxrljuUx0fS6/3ctvTiJQOjqWxZev9QtWaMUujmx3gzzZCksQ
        doCAh882yYY6JH9ArW3L3/atzPP+dQ==
X-Google-Smtp-Source: AA6agR5AEU/jYT72hAdHLSgqWhR554TIaKccfamcjE1XTrsryob+lpTFNZiTHrLk5HvSMUHFZ47BSg==
X-Received: by 2002:a05:6402:3486:b0:451:b8d3:c52c with SMTP id v6-20020a056402348600b00451b8d3c52cmr9859178edc.406.1663094648138;
        Tue, 13 Sep 2022 11:44:08 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.54])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0045256570210sm1970144edr.3.2022.09.13.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 11:44:07 -0700 (PDT)
Date:   Tue, 13 Sep 2022 21:44:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: procfs readlink after unshare() in a chroot() reports the full
 path
Message-ID: <YyDPdr7v/ltQI+wc@localhost.localdomain>
References: <12add75b103b412494487518c408fe0b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12add75b103b412494487518c408fe0b@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:06:32AM +0000, David Laight wrote:
> The readlink calls in procfs (eg for /proc/self/fd/0) returns
> the full pathname if unshare() is called inside a chroot.
> 
> The program below reproduces this when run with stdin
> redirected to a file in the current directory.
> 
> This sequence is used by 'ip netns exec' so isn't actually
> that unusual.
> 
> 	David
> 
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <sched.h>
> 
> static void print_link(const char *where, int fd)
> {
>         char buf[256];
> 
>         printf("%s: %.*s\n", where, (int)readlinkat(fd, "", buf, sizeof buf), buf);
> }
> 
> int main(int argc, char **argv)
> {
>         int link_fd = open("/proc/self/fd/0", O_PATH | O_NOFOLLOW);
> 
>         print_link("initial", link_fd);
>         if (chroot("."))
>                 return 1;
>         print_link("after chroot", link_fd);
>         if (unshare(CLONE_NEWNS))
>                 return 2;
>         print_link("after unshare", link_fd);
>         return 0;
> }

I tested mainline and 5.19.8, both are OK:

open("/proc/self/fd/0", O_RDONLY|O_NOFOLLOW|O_PATH) = 3
readlinkat(3, "", "/dev/pts/0", 256)    = 10
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fd94753e000
write(1, "initial: /dev/pts/0\n", 20initial: /dev/pts/0
)   = 20
chroot(".")                             = 0
readlinkat(3, "", "/dev/pts/0", 256)    = 10
write(1, "after chroot: /dev/pts/0\n", 25after chroot: /dev/pts/0
) = 25
unshare(CLONE_NEWNS)                    = 0
readlinkat(3, "", "/dev/pts/0", 256)    = 10
write(1, "after unshare: /dev/pts/0\n", 26after unshare: /dev/pts/0
) = 26
