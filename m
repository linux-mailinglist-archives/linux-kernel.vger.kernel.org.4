Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07453667DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbjALSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbjALSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:13:59 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8ED71
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:34 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id v6so174334ilq.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN5m404PqfKo6mXnNaQnC5y3bekflD0yVbmEP1ni1qU=;
        b=F+Ms3B4z8uVLxOb+TvJcbf4bzsbxEKmNBAxIsL3yrIq+dznAwC18CU/4tfCH/CFeYx
         PiiYw4AbnLoz4sVTfYNS7qK986hOsMlpC3zPQeGt4UsyUFlxL/fAgxLnSK2HOFxZXt18
         ABDsok2bIDpQ9OhYZ9O3unVVbRmi/FbMZci5+0bPot5IlAs/+UKoCujFuAlsRUHR+z9J
         td/H1TH/dUjfvltdzeLc/58s2FpSqXNzX5YLCkapQF3JaCIXzVP5e2tMjqrG9ktz8+KB
         CoMEXOtP+zm6R8dwXqlcacBxoKYt7Pn2EIbvZusAoW6yMwv3XYqjKEKuT891DT76yre5
         dPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN5m404PqfKo6mXnNaQnC5y3bekflD0yVbmEP1ni1qU=;
        b=j1czq1R+QGfwqtNttZIm66hZaOmXvbx+dn220+mna5GA4Epypmn/wve9S5vTaSJoOA
         7bLVSmkLUsrg6I2fmNU1jWwfboTJROd98r7ingR7nmLLuhtOhVy7Upf7X+N3U7qKRraa
         JOnpcO3eX8kFnL3bxiT12ZQwVemLbrerhV+LG+h/e0SxMJFstaYHQ7tsaP3qMpaIo8ov
         lSJ/sUHDTfSGrU5CvAMG1RSpuk5BMLMLOz41ZnpD3zHYKrZMp9a9CXnaUodNZ3YR7L4m
         M2HCuLVNQZwKHG0dQ8AE1+pYNd0KTttsIU0leQhLTYS+TBv02EIstsdUkO54/UrYAt2F
         dADw==
X-Gm-Message-State: AFqh2kptP3gNCQheNUrwduQ6Wm10FLRdhrJRvPOJo93MtpEgWCGqdYBD
        2M6GOzYviebhmSLLT3RbVcQqej5lkEbkFVGe
X-Google-Smtp-Source: AMrXdXtmoXDyCwb5E8LS6ZiL/M29SLWlLhJf9xwrWmo2j/HwoedCqsGBlmWt1xcK+sOFcE5cPmjqrg==
X-Received: by 2002:a92:c151:0:b0:303:9c30:7eff with SMTP id b17-20020a92c151000000b003039c307effmr11673649ilh.2.1673545413489;
        Thu, 12 Jan 2023 09:43:33 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l10-20020a02664a000000b0038826e709e2sm5324192jaf.111.2023.01.12.09.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:43:33 -0800 (PST)
Message-ID: <3c64a290-5134-2030-a2da-9ec2b1efc0c5@kernel.dk>
Date:   Thu, 12 Jan 2023 10:43:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: use-after-free Read in io_req_caches_free
Content-Language: en-US
To:     syzbot <syzbot+131f71f381afff1eaa35@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000077d5905f20e8ea9@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000077d5905f20e8ea9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 3:26 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1605ee86480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=131f71f381afff1eaa35
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

#syz test: git://git.kernel.dk/linux.git for-next

-- 
Jens Axboe


