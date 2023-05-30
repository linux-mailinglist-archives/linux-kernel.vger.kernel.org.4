Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E45716C69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjE3S1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjE3S1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:27:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE375E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:26:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so1165025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685471208; x=1688063208;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfAiPhU6K+BMQeqpdySZgN46jLEtUlo38yIT0HEk7Yc=;
        b=a3afgIpHXLDR+p6PUE88imzl1Fdd3I+Pd3mtn9+XPydzdk5TMgUOew7LiZopkYPuLA
         QdollxMgOifJ2zwonHK94N/UfFJloiAKymBvDgx7D/aA5zL95o3CoseMcbTnEjPLvnUm
         F5uT+JKIHlmS0rD8+QtE3uWgNSFkrG3v/h7zpF6OEF6dVru9qT6zyYTdulwsopUVPRsn
         4O15lj6YRKmXGdSf1l5rUAI0yF/PeHw+H9QLfUJYZPhQGoeylsAc6z7mBQdZAE0V18mQ
         8lCJr9MQ1lniDlerRHDsW3FYnP1+U67P8VPGJlIVX0D5JVVvuUYYPeoMCcDrNrUsKolW
         R+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471208; x=1688063208;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfAiPhU6K+BMQeqpdySZgN46jLEtUlo38yIT0HEk7Yc=;
        b=SS8y8EdXa90v8BJ+bRG9uv4Zp7/rBVPY+/RUC4K0m4/mQtbSyFm2vVi0f8DG5q7R4G
         jWDJeDVFkx/ntSJCODqZIkDl9i2lx5WzukE6l7lCQlvTauoRAwcS6vuffKnZipKuPTkx
         GfKnjuKpYfraKbD4WIvmVsiTn0BVmVATtix9rbQd+gWuu0kL1tOja0SoVGv5WZTSuHcw
         aVM/l3R/ltkEobhaU3HO8OuO1UnduK9DoDCuv6EpZDvL0r/PHirlp5hVIXI/2eh03Ht8
         WWL18DPXo8efELYK9n0pLK/7Dc7OvOMJpACSSRmoIb9H4WcyvWJX/hsGjSn3TAnPBiGg
         m5IQ==
X-Gm-Message-State: AC+VfDyV1QBgOCaQFCd9pPh2MGiQTLUctADzIMjo+lc4QyIZ5B4DM42A
        IzofFOQaPakC7s9vRT0Ae6w=
X-Google-Smtp-Source: ACHHUZ5aG44i0I28ueBuL5OztclzexCR7D7YTc0Yrd8/OnoqXdXXyvWoHZ9uq94s9h334lCsqCSVUg==
X-Received: by 2002:a5d:6984:0:b0:30a:8fc5:4411 with SMTP id g4-20020a5d6984000000b0030a8fc54411mr10453969wru.32.1685471208102;
        Tue, 30 May 2023 11:26:48 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b00306415ac69asm4029180wrx.15.2023.05.30.11.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 11:26:47 -0700 (PDT)
Subject: Re: drivers/net/ethernet/sfc/tc.c:450 efx_tc_flower_replace() warn:
 missing unwind goto?
To:     Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
References: <cbbbf576-6788-4049-b1e8-a05862f62cc2@kili.mountain>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <4eabd7b1-66b3-7b3a-cabd-d1876767c49c@gmail.com>
Date:   Tue, 30 May 2023 19:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cbbbf576-6788-4049-b1e8-a05862f62cc2@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2023 09:32, Dan Carpenter wrote:
> b7f5e17b3bb961 Edward Cree 2023-03-27  432  	if (efx_tc_match_is_encap(&match.mask)) {
> b7f5e17b3bb961 Edward Cree 2023-03-27  433  		NL_SET_ERR_MSG_MOD(extack, "Ingress enc_key matches not supported");
> b7f5e17b3bb961 Edward Cree 2023-03-27  434  		rc = -EOPNOTSUPP;
> b7f5e17b3bb961 Edward Cree 2023-03-27  435  		goto release;
> 
> This goto confuses Smatch.  It could be converted to a direct return.
[...]
> d902e1a737d44e Edward Cree 2022-09-26  456  	if (old) {
> d902e1a737d44e Edward Cree 2022-09-26  457  		netif_dbg(efx, drv, efx->net_dev,
> d902e1a737d44e Edward Cree 2022-09-26  458  			  "Already offloaded rule (cookie %lx)\n", tc->cookie);
> d902e1a737d44e Edward Cree 2022-09-26  459  		rc = -EEXIST;
> d902e1a737d44e Edward Cree 2022-09-26  460  		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
> d902e1a737d44e Edward Cree 2022-09-26  461  		goto release;
> 
> It looks like this error path is problematic because it will remove the
> existing rule from the list.  Better to just do:
> 
> 	if (old) {
> 		netif_dbg(...);
> 		NL_SET_ERR_MSG_MOD(extack, "Rule already offloaded");
> 		kfree(rule);
> 		return -EEXIST;
> 	}

Agreed on both counts.
(Technically we could add a new goto label in the failure ladder to
 just do the kfree and return, but this is probably clearer.)
Guess efx_tc_flower_replace_foreign() now has the latter problem
 too?  (And it _does_ want to use the failure ladder, because we've
 got to release the encap match.)

Thanks for catching this.  Patch for 'net' to follow shortly.
-ed
