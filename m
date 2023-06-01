Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065FB71E9E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjFAQJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFAQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:09:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47080E4;
        Thu,  1 Jun 2023 09:09:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f623adec61so11094275e9.0;
        Thu, 01 Jun 2023 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685635785; x=1688227785;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJy1XLQe0f69VJ3NGViu08fY1j4ecaxgtIAG9URJ/Bs=;
        b=VJFxoPl1CmAbELXfEoG8logTM8qe6JOzO30zfRdxMxiWz+idH3tnTWGnBTUDjgOaz0
         EdOeANV7bwV+TxZfQzTmV3YjVnhhLjZHYE4lznnExAPdkqmZXXOGdrLHvfc9hnXtLby2
         665jwMes+2yKtUxBfXyPl9lWoZt2szSkDtaOduns4p10VsnsKZBs7p7G+g2uxDkZcSar
         iqIh7gl+zSrKjeYzpeNx9sB/xM/Todela/FZge+RhOXsFE6p4t7yoyhd8Dk3NcEHt9Kp
         Urp3Kk951wBS4tvhNoNhUsN36+HGP/VgT7+fMmGHhzLRmJs3n6wzhko4pqsInYkuqF22
         I7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635785; x=1688227785;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJy1XLQe0f69VJ3NGViu08fY1j4ecaxgtIAG9URJ/Bs=;
        b=f2/m/ODXbe9Ev7T/tyRKe8TPHyh/Tl18rF0eSdFDF47NYXuG+q/jfWIYdh7hcqk/hi
         zVSY63Zgge7zekRGEPuTfcReM+wRcmTLp9Pa7RE4GkkVY1b3edvg5kbVenZi8WR/unxn
         y4XmnymUM9O1F8i+DpOLETTF4R8SWxbz1EBbYOhRsa7VYtmX3tlMgV3866rJYJiIIg9k
         tb1UYiCPECGXpAe5Epl2rq/ayEG5kSpkz59oSdVzsA/BVlGo497XZG19z0jiZtdcLOjZ
         7RzZsah+ECgbC3DidTIUb4sIUq1ccTWG1GESlBIrT0dTPQPaCh8s0ZbpzWxI8/F7BnAV
         HA1g==
X-Gm-Message-State: AC+VfDzfyzjOCopQTjoONxGucpVl3mzCub8F7ATEircg5ozwEjFDCiYG
        9eD3kIKbz8qnf0zFLVAmQ28=
X-Google-Smtp-Source: ACHHUZ5CBTdMBJ9puGi6YSqi6BrF6w/kSxUKAOuyg3MS+9FJZ4ZmJbyNOzWR2w995BVRfEwyPy/lPA==
X-Received: by 2002:a1c:721a:0:b0:3f4:f0c2:143 with SMTP id n26-20020a1c721a000000b003f4f0c20143mr1932245wmc.20.1685635785560;
        Thu, 01 Jun 2023 09:09:45 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003f61177faffsm9550124wms.0.2023.06.01.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:09:45 -0700 (PDT)
Date:   Thu, 1 Jun 2023 18:09:28 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com,
        richardbgobert@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] gro: decrease size of CB
Message-ID: <20230601160924.GA9194@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch frees up space in the GRO CB, which is currently at its maximum
size. This patch was submitted and reviewed previously in a patch series,
but is now reposted as a standalone patch, as suggested by Paolo.
(https://lore.kernel.org/netdev/889f2dc5e646992033e0d9b0951d5a42f1907e07.camel@redhat.com/)

Changelog:

v2 -> v3:
  * add comment

v1 -> v2:
  * remove inline keyword

Richard Gobert (1):
  gro: decrease size of CB

 include/net/gro.h | 26 ++++++++++++++++----------
 net/core/gro.c    | 19 ++++++++++++-------
 2 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.36.1

