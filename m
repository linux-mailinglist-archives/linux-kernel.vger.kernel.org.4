Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB274D96D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjGJPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjGJPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:02:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F3E0;
        Mon, 10 Jul 2023 08:01:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b71cdb47e1so4120530a34.2;
        Mon, 10 Jul 2023 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689001317; x=1691593317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+smcknHrpiFqVT0cxAi9rwiL8Xxn68TLxXVOwTZ5eD8=;
        b=HOHirMDwtZWJ82gvHYqNLnb0VERup2FZ9liADlXWv6oB2EO+62osD7McJXgnAmIfOH
         Ro5maxeEqNTQwLMrvbadbH+ndqoIW0j/QJIk4/LYzJ4BPBrdMiU/vi68ulO/PSyifVtt
         xj/iRAvDGAkDMAGNG3AK2GDpJEhxKHCAySdVnMQmy3jGOavQM6fXUPl1koj6fJjl/w55
         kBkAhR5L0ra3v6W/SdC4TenPLmiFRcifVerb9xEG3ahcplhkQFv/FEU77lkamrPECOFK
         AfvluZmHTPH1CmEdkoUwfIzKEWqv1ta0H1JIpxEonTsZhVV1Ql7SwXrEZvP4sZAH6BHX
         14NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001317; x=1691593317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+smcknHrpiFqVT0cxAi9rwiL8Xxn68TLxXVOwTZ5eD8=;
        b=Im4k79K1X/0uYpamx6Vh2L2EHy949vD10ilyJ201GveuZa0BSzGrXqMM78pmSo7M8U
         8DrqmMAcKwvoasudGgIDpyJ0Ca/CFplmmWP2k910JABJSTp3VhZ160mwIXqaCsDRZBMc
         qd9s326Paa1BC4MReEvoiCADohPRlzTE6JwwKY2wXahG1KZ8mWBhodW+05UTorIoPc8m
         CoQhtqSVPy+0vLTBziRhq6kACZxk2E255mqHePGqsOh53VzllxwlgjRI/w7NQffP7dAp
         dL+7oInWXKdzyCFnZ1J6VdjWpbMa1JY/RR2J93JlTE/hMxhDArZzaI5fq+3jkfYcOLY6
         un6g==
X-Gm-Message-State: ABy/qLYgxiOkiGaisnUTCLXxExoKvXn6Y2rGez/qnlIH4GbO4q2XEQML
        xzfq4/cr7SYcImU2BfYjCbE=
X-Google-Smtp-Source: APBJJlE0DQhL+lnXcJXKSvuZOuOKYgi9cKwt8vL4c23Ru3wlI4zLZVAQ0qV91+slvB9MbJ02kluZCA==
X-Received: by 2002:a05:6830:3b04:b0:6b5:6b95:5876 with SMTP id dk4-20020a0568303b0400b006b56b955876mr13400381otb.25.1689001317106;
        Mon, 10 Jul 2023 08:01:57 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id a19-20020a637f13000000b0055b3af821d5sm7564886pgd.25.2023.07.10.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:01:56 -0700 (PDT)
From:   pinkperfect <pinkperfect2021@gmail.com>
To:     pinkperfect2021@gmail.com
Cc:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        huxinming820@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        sharvari.harisangam@nxp.com
Subject: Re: [PATCH v2] wifi: mwifiex: Fix OOB and integer underflow in mwifiex_process_mgmt_packet
Date:   Mon, 10 Jul 2023 15:01:30 +0000
Message-Id: <20230710150130.2449934-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230708070749.2382045-1-pinkperfect2021@gmail.com>
References: <20230708070749.2382045-1-pinkperfect2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this vulnerability has been reported to and discussed with chromeos teams,
the detail analysis, see comments in below code:
mwifiex_process_sta_rx_packet makes sure rx_pkt_offset + rx_pkt_length <= skb->len
In mwifiex_process_mgmt_packet:

        rx_pd = (struct rxpd *)skb->data;

        // skb->len -= rx_pkt_offset, skb->len == rx_pkt_length
        skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
        // skb->len == rx_pkt_length - 2, if set rx_pkt_length == 4, skb->len == 2
        skb_pull(skb, sizeof(pkt_len));

        pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);

        //skip..

        // now skb->len == 2, skb->data + 24 is oob from skb buffer
        // skb->data + 30 is oob from skb buffer
        // pkt_len == 4, so underflow
        memmove(skb->data + sizeof(struct ieee80211_hdr_3addr),
                skb->data + sizeof(struct ieee80211_hdr),
                pkt_len - sizeof(struct ieee80211_hdr));

On MT8173 chromebook, the arm64 memmove.S / memcpy.S code logical
cause memove(dst, src, -x) a possible exploitable oob write vulnerability
not only a unexploitable crash

