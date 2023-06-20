Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6967363B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjFTGl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTGlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:41:25 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC6DCE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:41:24 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7775a282e25so379354139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687243284; x=1689835284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgq4aymOJ0VwVRpx8ThomLoDAuRp6iIasCSJOBre16I=;
        b=lSBBVJRM6vyNbU2krTrz3kA3FjawsgrfWkCHlS6f/QKkl/z21htBvrmd5yhgzmp5pl
         +4h66E/HqzhmmcWcJVvQ4XYJzxkPVxHuBOe9BDYZAv0Xh0nkUZ6JV2A6yirXm3eIHkAC
         slZScpZ7K9jpY+x0hZi5rST3IczVoR4mOXXe+1GZiLhurK5WtWyuRzllJ3eNKFVvWooR
         g726rHHscBsgklcFB+fGYglP22VI9WV1JW2VDeRcvZwjyYZAlKq5Bnv2M4YxJb9Bn5dr
         Uj/ByGXwsLDBli6jWtc098MZ69FxrQiTK5xC7E5TCV08NIXXelb4ZH/JKG4mswzhOJP1
         S7rA==
X-Gm-Message-State: AC+VfDz4N0BFvh8WJG7fvXiuZoerMif7S54azRlqLw+0hZn4rd9XDLNT
        jKnuc4TBR325/a79L7XJvpL7+5UpCYB2RYCADVQ4mQkKtH9j
X-Google-Smtp-Source: ACHHUZ6Orfc4iKNbp+A2S0qCgFR5kPjpvb2tLd5+FjEGOtDUON6Tmp5NyAFxOjuWLDW29xLn5EiVwxyoEKkYMr9BA4Vpi8NwG8Eb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:110c:b0:423:f81:a7b9 with SMTP id
 n12-20020a056638110c00b004230f81a7b9mr3529983jal.2.1687243283998; Mon, 19 Jun
 2023 23:41:23 -0700 (PDT)
Date:   Mon, 19 Jun 2023 23:41:23 -0700
In-Reply-To: <0000000000001f31eb056ea92fcb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097ad8105fe89f0a9@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find
From:   syzbot <syzbot+131cd4c6d21724b99a26@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, davem@davemloft.net,
        dvyukov@google.com, edumazet@google.com, glider@google.com,
        herbert@gondor.apana.org.au, icytxw@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, tobias@strongswan.org,
        tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 3d776e31c841ba2f69895d2255a49320bec7cea6
Author: Tobias Brunner <tobias@strongswan.org>
Date:   Tue May 9 08:59:58 2023 +0000

    xfrm: Reject optional tunnel/BEET mode templates in outbound policies

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eeaa4b280000
start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=131cd4c6d21724b99a26
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1140605c480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c92718480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfrm: Reject optional tunnel/BEET mode templates in outbound policies

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
