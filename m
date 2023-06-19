Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F957359DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjFSOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjFSOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:41:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52916AA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:41:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3110a5f2832so3478965f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687185691; x=1689777691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vRHMWvV6nRKP2P2dnaYnD/vJ4nVZEBNGPmS2g6sB54=;
        b=MBvkNTMd8+x2CMVqKe6KI1honpkMNSPACpdV8zTk8NUhDdbrWtK1dTv5bbULCwNTIL
         0X5v6oPGgjVOXFp5w8PkSzLFdpj6zq8I5jDqS85XX9cMWQuz5DbUvrRy055ONgUl1xwY
         VmcZ8bt432jtzQBi9O4tp6Po6tf442Z/4QhoXEhDn7vfvjIJezNwHl7CFUAdWEDrVbtu
         dQb14TPHw1kZGO8vh2WQxPJRyXId8tZmw+Jilj+YS4CnK3/F5mnyGZg8Z2dolXo9nc3q
         tBDZDvZ7LC77pzRHliK7tLY+W+OHu4ULcpTquyQ3GUOHFFnMPvH047lmlZ/ISKbrq6nj
         V1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185691; x=1689777691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vRHMWvV6nRKP2P2dnaYnD/vJ4nVZEBNGPmS2g6sB54=;
        b=GKPtl72n4pzC3qvrvE/WAmoLcQd5Oax7+7EyudC6aEmUGZOuURWfYsiKgbImvHeHE4
         1vqpznj8yobkv0SjgZsp+3qKQRMKkxo7LhCwgVrzJK4p9UOQvelfzAryeBfrWUXHiMaz
         3JGMPu8ii1t7EK5Gw3SJFyHh/fH6F0N+0UD8lcwzXYriTFDDSybKp03QVdJiu2XuQNMt
         fNCOj5Ij2NO3pKwirvq8m9tgwyTrbb2LNTNKon/73iCqOd9mzTM+ziEjBIv61GsIHfaX
         FSFs+CFllqpJoLzCCLpbMt7/aoYNPpLGcKgAjOiZ70D3+7ypUFF0xCljuoiEF3yss9yC
         350g==
X-Gm-Message-State: AC+VfDxnfftKkxhaL08bLrvcCKbjgNxzTEV/pGhRAZq3RksJdlmW6sLn
        OBATR4efH60/YqpSvY1w1f6j5A==
X-Google-Smtp-Source: ACHHUZ5JuZfNdQKe0TujONIhR4K2XB0lAjDXfzZYECblP+LvKNcA4TS0HaJJR0823aN+/fXh1L6Rww==
X-Received: by 2002:adf:ef10:0:b0:311:ff2:87e4 with SMTP id e16-20020adfef10000000b003110ff287e4mr8846429wro.33.1687185690687;
        Mon, 19 Jun 2023 07:41:30 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31795247wrv.108.2023.06.19.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:41:29 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:41:28 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mctp: Reorder fields in 'struct mctp_route'
Message-ID: <ZJBpGFF7870dcWe4@nanopsycho>
References: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393ad1a5aef0aa28d839eeb3d7477da0e0eeb0b0.1687080803.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jun 18, 2023 at 11:33:55AM CEST, christophe.jaillet@wanadoo.fr wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct mctp_route'
>from 72 to 64 bytes.
>
>It saves a few bytes of memory and is more cache-line friendly.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
