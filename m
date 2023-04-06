Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEE6D92E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjDFJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjDFJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:37:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7E171C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:37:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id dw14so25382157pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680773850;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG6V2hIp4KxEaYZavoXCGQJHZnFmzbqJPEufx9jNUSs=;
        b=Y+Pd0IpbpJ4yKGdkVP+Iy8i4yo+r/yqe/xczQW9l3X7M26ATOJw2IxyqL/Wp8qrymV
         NUrCQASnRGL4hzs8PiAi7mR8hQMICIxvIKumm5s4fEtpfl+E8qo8vx1HRoZvytOwNQAG
         BFuyLldBr3JTKZbcfhdabIqL542XNQDaoTSkNi49jlL/qnJ7iiQzpBZJ9i60+7fibXEv
         J0bA53eAUc+ovRTRoyAzbUJMaCdO04zYvQg/NxNeFz4uF3QT1yxrpP9mHnrJa8HU5pru
         a+7ZB/QBkHh2zjQT3y3a/9tg9EnYSmjHO6k1G7+aFjao6h/R15l/zXvqjDdmoMEN57fb
         EoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773850;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG6V2hIp4KxEaYZavoXCGQJHZnFmzbqJPEufx9jNUSs=;
        b=KWhl/tLGBqo1QnBvhiNbS+NVbfjQLeN0vj73yGGoO+9h3k9HM4E8NKm9fBJ9MbkteL
         T1cvb6yodtRH51MElh3YSN/l84uk8ut/Oqz+Oyeqi0ziz6Yr8weNzFkp7A+uzTR9xJcg
         unC3jYI2OgRylKTEdDjQBeZKXR3oGZPOXSF+esQky7x9NekN4AiGBnSZi/Snzt5cGW2C
         bscjcO/3zaG2TQ8xwbcFIHIvEsNF6lnnYWf/eVMAe7PtfX83Sq0xlCR4QQagKu93RH64
         za/lh2DzXRRCDBCjEbGRnKyWgIGUO249cAMEud2hw5jOWnanS4tqjsi+YcudCF4c7iHi
         s5PQ==
X-Gm-Message-State: AAQBX9cf9Thi/UHUS7JVRreqZnhTaTvWXSX0ePD5uAp9p2QzvXGddu10
        E1FcYq+smXMAtL4XFwDi2/CHOdoUKWCtUa8qU+17DA==
X-Google-Smtp-Source: AKy350abpOoXqsGJ0e8eYAJQToYD5BB8Z01R9n9+ZkDLcXnyfSrBfuwIOtUQMxnbCnii1LjV//fMgQ==
X-Received: by 2002:a62:19c2:0:b0:62d:944e:b0b8 with SMTP id 185-20020a6219c2000000b0062d944eb0b8mr8786844pfz.32.1680773850159;
        Thu, 06 Apr 2023 02:37:30 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00170400b0062e032b61a6sm935311pfc.91.2023.04.06.02.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:37:29 -0700 (PDT)
Message-ID: <4e345a16-bdc9-6f1e-9bb9-0ba35fa69e3e@bytedance.com>
Date:   Thu, 6 Apr 2023 17:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [syzbot] Monthly mm report
To:     syzkaller@googlegroups.com,
        syzbot+listf2f28c8e4d5809654f88@syzkaller.appspotmail.com
References: <00000000000032660805f8337db1@google.com>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <00000000000032660805f8337db1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, syzbot engineers.

As far as I know, syzkaller provides a reproduction code for each error. 
However, I couldn't find the code in the website[1]. Did I miss 
something? How can I get the reproduction code?

I want to help fix some bugs.

Thanks!

[1] https://syzkaller.appspot.com/upstream/s/mm

On 2023/3/31 23:01, syzbot wrote:
> Hello mm maintainers/developers,
> 
> This is a 30-day syzbot report for the mm subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/mm
> 
> During the period, 15 new issues were detected and 2 were fixed.
> In total, 120 issues are still open and 197 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Crashes Repro Title
> 1899    Yes   WARNING in split_huge_page_to_list (2)
>                https://syzkaller.appspot.com/bug?extid=07a218429c8d19b1fb25
> 176     Yes   INFO: task hung in do_read_cache_folio
>                https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
> 92      Yes   INFO: task hung in __filemap_get_folio
>                https://syzkaller.appspot.com/bug?extid=0e9dc403e57033a74b1d
> 52      Yes   INFO: task hung in __lru_add_drain_all
>                https://syzkaller.appspot.com/bug?extid=a9b681dcbc06eb2bca04
> 38      Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
>                https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
> 18      Yes   kernel BUG in folio_end_writeback
>                https://syzkaller.appspot.com/bug?extid=7e5cf1d80677ec185e63
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
