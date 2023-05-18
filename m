Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5E70784E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjERDEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjERDEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:04:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C840D8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:03:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64ab2a37812so13646862b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684379036; x=1686971036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdOEPtVD0Jz4dB2QzKbSOMAH3k2Bk3GtGeYA009YhPg=;
        b=qQdj+iG1qXqxKVXsxrTQopT3Qqsq3ltRyTCQUtp42gDcTiqeFnJ39MPoMcWTRxkJeG
         skQSamOcrNhtLTtl9RklLDpDHTy+CKfOcMAtksrazsiccYCv7Rnn9EGuUjN0z+f9XeMC
         BIxJuUGDARqMOrPIIcpvBOMHTBsuiPalNT8TYYJlQZOycChn4HaAXda+hwzkczpvqBBL
         XRtcVvXdVMvOA8Gg/b5LI9q5/PJOKnIoPIXzkJiiy1GG+vjfPBqHz/siMN2nEWnObe50
         MV1a9rfrXCEeCQG1U/C39ids0GOUcmeIkThs/AuiP0TSuYih5ehOKGztiitHZo9KAOVU
         2X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684379036; x=1686971036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdOEPtVD0Jz4dB2QzKbSOMAH3k2Bk3GtGeYA009YhPg=;
        b=O3Tlmf0QVKLezv7aWwVCKWaoGA/Tza599BIvav6tKcddDbzWGZwTFuervjMMlS1Cge
         sVXC54QkY8VrE8dm8aPDwvYLkir3UsoAJiR7dZi5iZgfTBljdFxyWF8FJ8mi352nwCVy
         s5XT2UbcsMdMfULzNEGdcHSf8phr36SWAzytbp4GHUPuqlDjmPOJhQRFc/CKa/C/mUP9
         hCux35aomopC816in1VhazRRHyM5eZZwyQSOkrNuNqDv+VNm8PKMSUvHYESXZ6XSfcnt
         EN23NobaMQF6XHP6Agu3YX3DvbbgIQ5r5mJ8GtEDnoXjpQpG8J46g0WE6muxwXEj75IM
         y6SQ==
X-Gm-Message-State: AC+VfDxcVlbLur4++Mwwu56wYPgWPoGyuq/oI36yFmozImTr+XUMo2gW
        Pd+VT6XVudu4FuS3O0TLCAXYFP5VEv8=
X-Google-Smtp-Source: ACHHUZ5e6yHH85gP+XzSABTn5svaZFnAiew1FdLVMy43tsJ1QBNJqBAKwZZ8ZTKff7Izcs1KmAmIjw==
X-Received: by 2002:a17:902:f549:b0:1ae:b2a:8ed7 with SMTP id h9-20020a170902f54900b001ae0b2a8ed7mr748469plf.29.1684379036236;
        Wed, 17 May 2023 20:03:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001a064282b11sm113619plb.151.2023.05.17.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:03:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 May 2023 17:03:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET v4 wq/for-6.5] workqueue: Implement automatic CPU
 intensive detection and add monitoring
Message-ID: <ZGWVmon8oQPvJOw3@slm.duckdns.org>
References: <20230518030033.4163274-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518030033.4163274-1-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.5 w/ version tags in patch descriptions dropped.

Thanks.

-- 
tejun
