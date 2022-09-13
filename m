Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D75B7CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIMWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:04:41 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976B626B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:04:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id be18-20020a056a001f1200b00543d4bac885so4163530pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=jxDIbtQ66PrWz6a32rJE0ccGslBcTnVeTR/OfIh+HdY=;
        b=Hdvb1QDi6FiIA8UOVSy7eEjRFemELD2e/V5GGGOnkjl0Txir9PJxvBIIbQeajrnuvo
         emwibrffPzGebHJyqKEesBSExuk0ZsjlHdg+vsGEZHLihzpkTMcDcW9g99XVyIPDDBdN
         opL+706gmXiI/rbnuKhSa306PeyaLZaIZQk/f2FNpvmwOWccNdcGiVtki6VD9Zwsy+iP
         qKTO9DdS92AvIOzhCk5nymjIKI5gX4lgT3o0uhENJdyJ+Gysmnpc842qsML61lHnYObi
         baW0sfyXgSEVf5GDl0KRC30fZyiTiQepS9+WcqfDlOZXOBFVm36nnxJ54HXWoeJIt+K4
         JiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jxDIbtQ66PrWz6a32rJE0ccGslBcTnVeTR/OfIh+HdY=;
        b=SO76IMSWHv38iEzWao0PbC4wWgjD0j5uCaB9KeEipUO9m7lDPLHYxtYrJGMqo6GkSZ
         N4HQee56pI+VNmRD3YGrH4Jl19b8zxmlknx1hxBimzHibHOg4TXpmYmWW/gdZdNER5nb
         /WCahOw9wyI0eubgndk1c7tE5pIs33ZABXJT2bsaDz7Ck44hF5V1KnkcAQ6swIZLVCfz
         I1oAr28aR81QYKL/KnDTTCmOoLLdN63WpebiEJ22A5BxM1n7v5mdMHr6csteRPWlCNVD
         24M6NrhF7448RtHMcAdYg7teZi4DfipA5Ur+e/jUbZRJrMRy1ymaq4DDA1bRb5CoaLEF
         ZgLg==
X-Gm-Message-State: ACrzQf0rbXwsjvVDf13wGQ8OIiVvnDGKbK/+h4OnAzH2XloQo1ETH1MW
        YU3RcBf4t8l5l/XN5sP/+8MRCzjT+04W
X-Google-Smtp-Source: AMsMyM5ghBnTaJVBUu6s4yszVZmQxi8HUmp6FZZvLliSFWGE0IKnCoL9KxrEf3upV48YWjCwepuOJXnETSdL
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:7343:b0:1fd:d6fc:b2f with SMTP id
 j3-20020a17090a734300b001fdd6fc0b2fmr1370972pjs.65.1663106679074; Tue, 13 Sep
 2022 15:04:39 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:04:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913220433.3308871-1-jiangzp@google.com>
Subject: [kernel PATCH v1 0/1] Bluetooth: hci_sync: allow advertising during
 active scan without privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows the device to keep advertising during active scan when
ll privacy is enabled, if the device is not using privacy mode.

Changes in v1:
- Check privacy flag when disable advertising

Zhengping Jiang (1):
  Bluetooth: hci_sync: allow advertising during active scan without
    privacy

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.2.789.g6183377224-goog

