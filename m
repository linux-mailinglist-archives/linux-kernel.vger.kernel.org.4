Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C888E6369E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiKWT0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiKWT0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:26:46 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C108C68A0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:26:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2740724pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3WrAzDPudv/N0fFjJ8SL7oPiRD9eMmVpO3nvXd78v0=;
        b=OXQGFIc0zDHAjSlWI+XLcnV15vlXQ76znaitE33fPdGBhZP9taXZIRAq+dQs5CKwZg
         kdZ/uqkRRtwK8kjQgKhXtCP+GsVjjhXmNxMu2XDHAywVODMHyj2L4QosxNkbSYqwqQIc
         23Aeqlb2KassYCE1tAHcucDhr11xYl7Qwi+6fzS/jHH2BPZJhCX/CR+xwelqO75RlavM
         cgBwkV/KNioLbPxxE6QZRrrGURnbE+VgHWjK0iDnZZtti9O3ZW5Tiu3JkGoso+1ls165
         XZftXmQQK7/RRV2BiZ8Dzw+W/ZtHhCoA94JObJ30ELED6xspw95JxRc1BURYxRmUPkkr
         IaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3WrAzDPudv/N0fFjJ8SL7oPiRD9eMmVpO3nvXd78v0=;
        b=5B+eHteEQsAURNftwt/j2Mrp/q6hi2GK5M8mO2IODBi9eaMfekhKax01rPhZWIjtNj
         UtCKeq3DXh8iqgBznRcn8mgQNMY4y2tdz7qTdUm850IyXz3qsuIeUk4+UhRRl8TeOae3
         IniR+aCVIxFAypNt1OTzmQq5GOW2lOvnGrUPqrDDtRbdnh3KfJ2KdRX2DSFwdQrYm6/k
         AkXfDYZXFbV6fCOPaGpvVDusB55sZg8o4wquPnesxiSFtHdSxKOEesXABdvRVphDY3Rr
         y2RXvL+M6CWaZCNflkIWDbTu7AR2DAA+zPgGkaUXONpBWdAsdQjL7lkFBnb5hMnzxqkz
         KA4g==
X-Gm-Message-State: ANoB5pl3ye8m1n2M3m4Kq2tURh6m9HQR0Koh74OTnFPyLBODF2robjDB
        SGyejdKXULu1C5LuMhQj67g=
X-Google-Smtp-Source: AA0mqf6TMq1mfAuZ3P096lwxED/tRtqRsPf0impJ4ixxv1Aftcslt1tjSaosFwNBCnJZDRmK5/CYeQ==
X-Received: by 2002:a17:90b:2811:b0:213:971d:51b4 with SMTP id qb17-20020a17090b281100b00213971d51b4mr36199326pjb.180.1669231604938;
        Wed, 23 Nov 2022 11:26:44 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b001894dc5fdf2sm1534140pla.296.2022.11.23.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:26:44 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 0/6] Implement writeback for zsmalloc
Date:   Wed, 23 Nov 2022 11:26:43 -0800
Message-Id: <20221123192643.2956114-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221121192916.1157438-1-nphamcs@gmail.com>
References: <20221121192916.1157438-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suggested changes seem relatively minor, so instead of sending a v7
series of patches, I've just sent the two fixes in a separate thread.

Andrew, would you mind applying those fixes on top of patch 4 and patch
6 respectively? Thanks!
