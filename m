Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9F70D498
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjEWHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEWHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:12:59 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1505109;
        Tue, 23 May 2023 00:12:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75affe9d7feso284133585a.0;
        Tue, 23 May 2023 00:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684825978; x=1687417978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZio8i4os+gLoYXTEzFCmPH/ORb8tIGBKsfZ/7cCq7c=;
        b=JWw9npV1kf2wKf7B+Jw4ftA08GL1o2tZ04iTcoa93iBqVTLDGkBX8UGWRB7Tpizwkw
         laQjJFgGI2oAqiNkcAPXAw7+uP230SgwH6xMECF3u+h+IxOCGOUP+VskIG7xxplZReJK
         J2IrKYN4ccB4DZVfvo3hUTrPrtkAsxKiyY+WssNI4joPzXMccgWG0jU/rH9s4mUg526q
         EYpzlUt2OZX1WAg4i28hoMI57bLj5BK1qVhTJCRk4xOeXWiTsKsvW5keN1XI7T04VY0a
         c7Y8Po0Del6DNrnKpnZ03uPFPKJO5OAeKZldFojN9Iu9I3+wAJKw94hxecKiSAAfrJpV
         /bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825978; x=1687417978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZio8i4os+gLoYXTEzFCmPH/ORb8tIGBKsfZ/7cCq7c=;
        b=MvXFDPN8dn3mXogQOg7gYv8BHtoq6b+K1V4+kmA3biN3Wvamhf6yaTOab+zcrRYlAY
         qU9fdnMrVM09s9GpLyPVXnpwK36nw2YwxG4yYmu5MPdffGn8+a1HV8VpvY8MvlpgnwSr
         G+5ngEaqq2aWZgsLAhLMO4JYthKe+lfwEXwlh8JdD8Wmx6pDcnThvfwhe/Q59at7oHDs
         ezd8sU1h7a0aIZWzTP64un1MuiNlrLAVPaj9ZGZAKMgmXTDwVgPstn7ZlhwL2DnI7wWq
         f8ZZyHACR20rgxq66os6TdF6E+YNm08QqiMtYeDYmlFrWoi5SJ0gGgOgK7lnmCXyPD5o
         N+Pg==
X-Gm-Message-State: AC+VfDwC3P3/Y57gJtIRJu45Lc4XSHmGvEIQHRXFnlxMMH3Q01Iu3QtM
        OW3bQ/uU7GLhd9Ch1ZDsCg==
X-Google-Smtp-Source: ACHHUZ4bKn6c0cGvb8XoCuxJIx1z5ZufZMLTCw5EGwuwjRbps/XikWFVh1iZ574IYItLkMeWc8KDHQ==
X-Received: by 2002:a37:6c7:0:b0:75b:23a0:de9c with SMTP id 190-20020a3706c7000000b0075b23a0de9cmr3193975qkg.26.1684825977798;
        Tue, 23 May 2023 00:12:57 -0700 (PDT)
Received: from C02FL77VMD6R.bytedance.net ([2600:1700:d860:12b0:18c1:dc19:5e29:e9a0])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a159800b0074fb15e2319sm2307342qkk.122.2023.05.23.00.12.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2023 00:12:57 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
X-Google-Original-From: Peilin Ye <peilin.ye@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v4 net 0/6] net/sched: Fixes for sch_ingress and sch_clsact
Date:   Tue, 23 May 2023 00:12:39 -0700
Message-Id: <cover.1684825171.git.peilin.ye@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link to v3 (incomplete): https://lore.kernel.org/r/cover.1684821877.git.peilin.ye@bytedance.com/
Link to v2: https://lore.kernel.org/r/cover.1684796705.git.peilin.ye@bytedance.com/
Link to v1: https://lore.kernel.org/r/cover.1683326865.git.peilin.ye@bytedance.com/

Hi all,

These are v4 fixes for ingress and clsact Qdiscs.

Change since v2:
  - add in-body From: tags

Changes in v2:
  - for [1-5/6], include tags from Jamal and Pedro
  - for [6/6], as suggested by Vlad, replay the request if the current
    Qdisc has any ongoing (RTNL-unlocked) filter requests, instead of
    returning -EBUSY to the user
  - use Closes: tag as warned by checkpatch

[1,2/6]: ingress and clsact Qdiscs should only be created under ffff:fff1
  [3/6]: Under ffff:fff1, only create ingress and clsact Qdiscs (for now,
         at least)
  [4/6]: After creating ingress and clsact Qdiscs under ffff:fff1, do not
         graft them again to anywhere else (e.g. as the inner Qdisc of a
         TBF Qdisc)
  [5/6]: Prepare for [6/6], do not reuse that for-loop in qdisc_graft()
         for ingress and clsact Qdiscs
  [6/6]: Fix use-after-free [a] in mini_qdisc_pair_swap()

[a] https://syzkaller.appspot.com/bug?extid=b53a9c0d1ea4ad62da8b

Thanks,
Peilin Ye (6):
  net/sched: sch_ingress: Only create under TC_H_INGRESS
  net/sched: sch_clsact: Only create under TC_H_CLSACT
  net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact)
    Qdiscs
  net/sched: Prohibit regrafting ingress or clsact Qdiscs
  net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs
  net/sched: qdisc_destroy() old ingress and clsact Qdiscs before
    grafting

 include/net/sch_generic.h |  8 ++++++
 net/sched/sch_api.c       | 60 +++++++++++++++++++++++++++++----------
 net/sched/sch_generic.c   | 14 +++++++--
 net/sched/sch_ingress.c   | 10 +++++--
 4 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.20.1

