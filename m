Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB995655C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 07:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLYGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 01:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLYGRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 01:17:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FC26E1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 22:16:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m21so12218031edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 22:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDk3gigvSmNuCA+9xYhNGe8968oX2YmE5u/xXeYALdY=;
        b=X8Z8jf6rL5GGuUZtcJpP4YmLxcP9A3ViKKBEtvZM8Ybb/any5mMFIFwRWUo18YWFDA
         L/Jpssz0Gw2cUYD8OtzBxCMRiCsfPrze3qlVjsZ8sR2VgutXl6Cmy1ujzdvEhQqnqfzo
         JnHeCDDVCT3nvy5hDug5CNnf3x6NMSHo9FCFQ9+lnMOdWhPiXWq3o++hBjsagi/cSTP5
         aut1LpVBo8EwKkIwCLODabgck3BGY/LBdNTxcNTxWyQppsZBkaIX1lbqbTNCZwWLHY3z
         SAxAN1Wj9ktf7uMngF1ikBQzXzO6F5eewD24+/3ln+cUGvfx1IFM81Va5E/mvsoDVTQg
         RS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDk3gigvSmNuCA+9xYhNGe8968oX2YmE5u/xXeYALdY=;
        b=WNZF6dGM0sw55RcgWj7idVYiRr3LYrCxpQvQ1YjzbVGEwtVlmRNq8smstF9N7CfFR7
         rP10JIWBdN3edSNQ4CBgrX8QEfybma3CaXeCi7JLHNu/WViAj7Z6hgI7zANGORkolUXT
         RlPRYx7EhW6EkRH+sizeQOcQeA8nkKcBphbvWO2wPWloiisQ6iCYvPPR6umngRhkonfE
         LQki/tJ8EHrfptKbafyVfTvz5/w2STO7cslPd9mqxbDBmg8gBwe7qG1rTMGjGDWSpOJq
         KmK/h8SFT1ySxIByfWCK13ePunmFrg//ua1VQnWTdKZOqnfpb0sXB36PxdF3gVn92sf5
         3Zpg==
X-Gm-Message-State: AFqh2kpd3ur8V6soPo0CLz2kM2kkcHkP5rohiCeYNcwKavWyBDgTp/Nl
        qPEy/3v0ns3/z72Q/naOOhEUNxgN5FG6Dg==
X-Google-Smtp-Source: AMrXdXuVEp1V3IsALzL9RkSOA3P9uJyE/iREGygaWchGFEG5ZmLeeZAhGqLE3xI0sdO+2RUt5OE9Tw==
X-Received: by 2002:a05:6402:174c:b0:467:8dd2:b42 with SMTP id v12-20020a056402174c00b004678dd20b42mr11793905edx.10.1671949016893;
        Sat, 24 Dec 2022 22:16:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a12-20020a05640213cc00b0046bf7ebbbadsm3270540edx.42.2022.12.24.22.16.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Dec 2022 22:16:56 -0800 (PST)
Date:   Sun, 25 Dec 2022 06:16:56 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: should get pivots boundary by type
Message-ID: <20221225061656.o7bl66m7oez4q67m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20221112234308.23823-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112234308.23823-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I ask who would pick this?

On Sat, Nov 12, 2022 at 11:43:08PM +0000, Wei Yang wrote:
>We should get pivots boundary by type.
>
>Fixes: 54a611b60590 (Maple Tree: add new data structure)
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
>---
>* kernel build looks good
>---
> lib/maple_tree.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>index 73e2e6434e2f..2123d1930a9b 100644
>--- a/lib/maple_tree.c
>+++ b/lib/maple_tree.c
>@@ -669,12 +669,13 @@ static inline unsigned long mte_pivot(const struct maple_enode *mn,
> 				 unsigned char piv)
> {
> 	struct maple_node *node = mte_to_node(mn);
>+	enum maple_type type = mte_node_type(mn);
> 
>-	if (piv >= mt_pivots[piv]) {
>+	if (piv >= mt_pivots[type]) {
> 		WARN_ON(1);
> 		return 0;
> 	}
>-	switch (mte_node_type(mn)) {
>+	switch (type) {
> 	case maple_arange_64:
> 		return node->ma64.pivot[piv];
> 	case maple_range_64:
>-- 
>2.33.1

-- 
Wei Yang
Help you, Help me
