Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05E678BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjAWXLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjAWXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:11:06 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A4532509
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:11:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so8245084otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fjIYAm4DPxTtphwtDW3/98BXT3S0iNOLETlS7FtGTbk=;
        b=R0/RuSpBEgEljDS266lVw9uRQH8kLvE4FhrzQm1izYbziJL0nMbP3At39OYAFo/4GE
         ap4pazDbuQhqFiCZibJ/ArGGEXApKQzyI6M4FOgK8VLiWaw6tbT77/Q00ieq9Y1dFx5U
         2SeawI4S4dIFcuE4f0QL1bCqD///lCan8JqqmhK9lyQp9RN9Zeu7cn/V+VP4oqemshdz
         uGxnCEMJ+i01VOdnPmuSaBpZn7cUIoHi/QKcQDTXMWIZxOrJKdk5EMQvcDvGUq/UoFcB
         jxN/A0z+BnpIWMZa9vliH4Zt0EnsVBebVcMHpebsOlOPVCAAsLM3J0LaKT55Uqsz+dPq
         T7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjIYAm4DPxTtphwtDW3/98BXT3S0iNOLETlS7FtGTbk=;
        b=MFNGv0MsArcN2lI04SrINfF3TNVF0PN3cYPCw3Xuy/MEEocha7QyYkqhcSt2BMVPsk
         oRhO1MookpW1aBgQvk5x0x1Oj2+M2AV0zMDbhzVJRoGLyUtlG5MPau6ECSO4mVSo+Opx
         i9otf+l1bi7wqrWtmC6KP52qYAfgkVmSt8u/a6t+csK9TPFeZP/qQcNQcciRW94vC2xK
         qqF1oTJi8yc4hARDosqOrZyYtirSw0zmAlWDQUn/WjQAqdpyPIp9yt0u9PaqXorFCjaH
         d0NrEvXYWF2M/tiIVovs7N4ktbBdi98et3ojk3ErZokf6y8YWJpG23ypj6ojEd+oqsGj
         0JEA==
X-Gm-Message-State: AFqh2kqWJiCp04ogZTvYWUihqD0KrC01MUXeVKDFnfSj1RW6irjuS4mV
        JCqCmA6cMEirPVAQ9TbwRxzVZQ/bgx8=
X-Google-Smtp-Source: AMrXdXuSpEglbIWi5GRgUwEjg1svH3yDquXFF5W65TpWCwN/+fEBoGJwbRltHY7H6EdMEs4lRsRf+g==
X-Received: by 2002:a9d:6292:0:b0:684:dc7f:3954 with SMTP id x18-20020a9d6292000000b00684dc7f3954mr12827688otk.16.1674515463600;
        Mon, 23 Jan 2023 15:11:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18-20020a056830105200b0068646a8223bsm226938otp.57.2023.01.23.15.11.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:11:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 Jan 2023 15:11:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Subject: OOM on objtool when building x86_64:allyesconfig on system running
 v6.1.x kernels
Message-ID: <20230123231101.GA3398733@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

when trying to build x86_64:allyesconfig on a system running v6.1.x kernels
(currently 6.1.7), I keep getting OOM errors in objtool.

[360871.492187] objtool invoked oom-killer: gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), order=0, oom_score_adj=0
[360871.492194] CPU: 4 PID: 1158479 Comm: objtool Not tainted 6.1.7-spi+ #1
[360871.492196] Hardware name: Micro-Star International Co., Ltd. MS-7B89/B450M MORTAR MAX (MS-7B89), BIOS 2.H0 07/27/2022
[360871.492198] Call Trace:
[360871.492199]  <TASK>
[360871.492202]  dump_stack_lvl+0x49/0x63
[360871.492206]  dump_stack+0x10/0x16
[360871.492207]  dump_header+0x4f/0x216
[360871.492209]  oom_kill_process.cold+0xb/0x10
[360871.492211]  out_of_memory+0x1cf/0x520
...
[360871.492254] Mem-Info:
[360871.492256] active_anon:743423 inactive_anon:6755060 isolated_anon:0
                 active_file:847 inactive_file:1145 isolated_file:0
                 unevictable:665 dirty:8 writeback:0
                 slab_reclaimable:475477 slab_unreclaimable:69268
                 mapped:2213 shmem:760735 pagetables:16035
                 sec_pagetables:0 bounce:0
                 kernel_misc_reclaimable:0
                 free:92647 free_pcp:10 free_cma:0
...
[360871.492446] Out of memory: Killed process 1158479 (objtool) total-vm:25987600kB, anon-rss:25766820kB, file-rss:1444kB, shmem-rss:180kB, UID:1000 pgtables:50464kB oom_score_adj:0

The system has 32GB of memory. I do not see the problem on other systems
running v5.15.y kernels, or on the same system before installing a v6.1.x
kernel. I don't think I have ever seen the problem on the same system
when trying to build an older kernel either.

Has anyone else observed a similar problem ? Any idea what might be
going on, or what I can do to help tracking this down ?

Thanks,
Guenter
