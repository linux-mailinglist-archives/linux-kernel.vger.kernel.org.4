Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97F667DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjALSOr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Jan 2023 13:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjALSNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:13:49 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A46DBAF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:18 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso13983498ilu.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mJ/3NEdJjcfIwphz3ctLNzvcyG4TGwGYyLvC3FGbeU=;
        b=QIW8pHDBM/qA/DTcmwkbvgVponpdUbP0A/Z8LuEWks9BQ3nXzzL/8mUVjNz/k7vlNZ
         UYuDXKqVZeAbULEwhcyc4O5hdQzX12PgclXlBFxL6ZcDreUjmryNPq/RAC70UzLPc4ho
         CzSjnRlincK12obXjN9yFOSlbcpNC1jBlgPhqhR8tkiEfE43+nC1HOyuP2Fzv0a6AbHT
         NdEP5aZmbrOo3Exfss7A/O+s0MGyAjG5jiwlfCJNkM1dyOAr6al4FkVqZb6Z96/pYDSx
         ZvVMTTVsvWlsDgAsyUW8zgAqL5Xjif4WzhppjnHNuL0I1ASdgywixuRHIs/77vhZQLI8
         7+cg==
X-Gm-Message-State: AFqh2krlESC58YIU7PE2BegnJvVN6w9mYEJ22XwxtNZgLw7qwYvrzR2i
        0MrvqIGTxLkGt6jQhd+6/smsJ3HpuyWqkuDw9xNKaU78iEoX
X-Google-Smtp-Source: AMrXdXsi/nM7b2/T2ZImf2mdRFJBqoTWqs7nDy7uSg47A2a/jY21QFeZggHBd3V2E/8L2XD1GMgfLU70Qc4Fzm4TQPfw2wcsXfm1
MIME-Version: 1.0
X-Received: by 2002:a5d:9644:0:b0:6ec:c7a1:aa0d with SMTP id
 d4-20020a5d9644000000b006ecc7a1aa0dmr6588951ios.139.1673545398261; Thu, 12
 Jan 2023 09:43:18 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:43:18 -0800
In-Reply-To: <b130dd91-0871-6138-9a40-8499fb776875@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa9db705f214a6c2@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in __io_put_task
From:   syzbot <syzbot+1aa0bce76589e2e98756@syzkaller.appspotmail.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 1/12/23 3:14 AM, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d269ce480000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1aa0bce76589e2e98756
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>
> I know there's no reproducer yet, but when there is:
>
> #syz test: git://git.kernel.dk/linux.git for-next

This crash does not have a reproducer. I cannot test it.

>
> All of the ones from today was due to a buggy patch that was staged
> for 6.2, should all be gone with the updated branches.
>
> -- 
> Jens Axboe
>
>
