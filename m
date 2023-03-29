Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA496CEC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2Ozm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2Ozl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:55:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CA1718
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:55:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so64687903eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680101738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ult/ejLsoGkxOcm1OAQ4n/1DUPXwVhbqifVVNbYHzAE=;
        b=kROj4AzxnWoycSJlGuw9qz/pVCT5PuY1lLDasrLKa3/n0faUb3e9QigDjbrg7k6lN5
         e4DknynsNCVAF9EohwPv6yNaPwr3qX0PV5HEHcL2dkBNkFhTPOUmFZybaSRjyOocQ0yN
         MXFCFHcqziF0LoQ6ks81bM9DuSVZLRCC3Pa8X31Nu90uvBOnLAz3MweiAbURvpgMWrdb
         FY2Ayv3WCnn27yDXpAOE5FaRfkagEPSHbcDtv+5a2iTCEhPX3Xn5vPeYsOTWSka3BaNT
         zfZVjO01GPGe+U0vb+lxepnOJ0pRHvCUOOfDHD3qGmMPskwJMN+k23ATAVADlh6IUCX5
         6jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ult/ejLsoGkxOcm1OAQ4n/1DUPXwVhbqifVVNbYHzAE=;
        b=Cvm+FlCmE0WqtOBeOfwq+ewCX4EKE604D+LoLNpPeEJX8aZeHtkHKV8AKbQbihOcFq
         OG4LhGUs9JHV+YQZqabEu2wzkhJ3fL7kESIuSUg5NLdF+7PohrlDG/LbVIQ69KHiITou
         in2o7u0E0vFI5YHkDzZpMgxW+n4Q/fDx1Z/WgDEpQlX2VPtZxk5dNcSpUuxns+848LaW
         H/xSTwPeNh0QdHuKuTqsXAv7bMDJUHfOXRKxKL7ne/844v49JneZDLVgOl4oZ1mwtUtu
         rpCHk55jIpmqbIw0SNxgtX31oocfYbBB+Rjiu4Xls+c2r5Q8+smjfkJixEnY3ii6vnBi
         VTlw==
X-Gm-Message-State: AAQBX9chxEwerWuCLMVXUVK3uwYpgdcYcBv4erRZ/3LWYoTEbKgafyUK
        4CEGbmG+sJbCPHB9eD7+XPmuWw==
X-Google-Smtp-Source: AKy350YSvV//7Yt4IYbsf+hnXMJZpyjvQSaofY/td/PLeqSzvwzLYBpC+/O7+M+kwHfDQ7YfiCB/TQ==
X-Received: by 2002:a17:906:6a13:b0:92e:3944:716d with SMTP id qw19-20020a1709066a1300b0092e3944716dmr24968402ejc.3.1680101738533;
        Wed, 29 Mar 2023 07:55:38 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:e994])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709063e5700b00930b13f6abdsm16685578eji.98.2023.03.29.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:55:38 -0700 (PDT)
Date:   Wed, 29 Mar 2023 10:55:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: mark folio as workingset in lru_deactivate_fn
Message-ID: <ZCRRaHHKVt7fpvmD@cmpxchg.org>
References: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:47:35PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> folio will skip of being set as workingset in lru_deactivate_fn.

Can you please elaborate why that's undesirable? What's the problem
you're fixing?
