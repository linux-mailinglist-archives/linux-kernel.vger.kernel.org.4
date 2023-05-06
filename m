Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8646F90EE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjEFJgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjEFJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:36:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B39ECE;
        Sat,  6 May 2023 02:36:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EA435C005F;
        Sat,  6 May 2023 05:35:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 06 May 2023 05:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683365758; x=1683452158; bh=W
        hKrTyJEAyCUMMB5cfUBewlKxI58jwdpn9YfS92b3dg=; b=eRVxFphIXwdZFLUPn
        jPwJO2ZGYXT5eYs4OY9zaHTe9HSnOA7quCC6hGUEUgLslui+BScbR27DQRkPD+JT
        zrKs1nmT6vriAgPC6ozklipykcCw2FObu1DQ2ldBCRcHlrkEQqPrPpktO+WgwFVs
        O9VxxLY1wuBjlyFaHqra+2Asm1SjB0bZrnPkyjTFR6A5+Fy8qUE85dRCx2j6yVZk
        7vm7qCnz+38u5vovV4DPmfJrNSfLptha2b98sy9lf9THpu5x29p80kZf52Vpq1ZK
        peZCKc2qx14rvldz9sFWEPvJYn46g/YjidPplqjlbfGFFivtGShebFbDv5NRNG+i
        Af+tw==
X-ME-Sender: <xms:fh9WZJgHkhzOxY2JPsvBvYxtnbbqHpYNfc9CdaO3vdeq7tiqWmgBBg>
    <xme:fh9WZODnFXVhGuMwGUGNJyIEUA8Pz1z8kMWyQyyBeiiJP4vzYZ-XOX052EzWvjI7u
    I4w0rRMIe16iIzm_HI>
X-ME-Received: <xmr:fh9WZJFSh4IvjhPXnkmUZfSNLGXGqJr5uv3USAzl4BuZVL5zNRU0jv6oN8nzOMXPMCFbyXDYwJzWgRN-l07pTOBP6Lc2kdWRogs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkhffufffvveestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheffudekteffudetvdffffehgedtteekkeefvefgieethfevvddtlefhuddutedt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:fh9WZOTZW0gGU9gTVwGKXVxjtHkDoUrLVdIfepZJeEuz0UogsPZOMg>
    <xmx:fh9WZGxiUifUMOiT8Qw9Fzxum-AiLG7vnrpS-3HnTLpGSyKa2ZrI7Q>
    <xmx:fh9WZE6M96Z32c7XFP6ywU7a7nF3KmtK2GwUW6UdHiBuwXfoiKDLXA>
    <xmx:fh9WZK_t--QWg4HPT7aroil0KYXTH-dZZX4u5zXfYIejyJElk8OmUw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 May 2023 05:35:56 -0400 (EDT)
Message-Id: <cover.1683365892.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v1 0/1] 68020/030 signal handling following exceptions
Date:   Sat, 06 May 2023 19:38:12 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Andreas Schwab" <schwab@linux-m68k.org>, stable@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents potential stack corruption on 68020/030 when
delivering signals following a bus error or (theoretically) an
address error.

Changed since RFC:
 - Dropped patch 1 because, as Andreas pointed out, it will not work
   properly.


Finn Thain (1):
  m68k: Move signal frame following exception on 68020/030

 arch/m68k/kernel/signal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.37.5

