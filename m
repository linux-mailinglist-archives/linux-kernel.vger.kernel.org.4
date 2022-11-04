Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3399618E31
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiKDCUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKDCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:20:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5251388A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:20:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h193so3225705pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btmbZscjcgDV6gMUkQqZSyJ7vtSOlzDWHe+5X4DPrdw=;
        b=Z9ekQ021oBqePrZb0PF85YgRCJdpGZ83zP2Q6+YbtdzK5IIDLfkC1zQOaqtVEwUccq
         CxQWDQQQwW+9FVibWg8vkXorcy8CwvyX+F/wNf1/+H0aHTddP3cawWdk9o5RJ0tbqfOP
         FvnkZHZkPOrbDsOkt3UfXyxcUWFzhMJ2VSd9+wpfIHGsDULeeNhTBfniAE9Z9u5RBx2E
         YVZXLbMssRgNNwrSiAyxc1PZYC9RmVOZlIWQ942aHS+504sCbndzulXdEuhqHhWAAZmz
         Kp1N9A7AJEWxpi8ufprZ8ICsVkg+Lk90VrTcDV69pV1bPlLioO34HBYgviUL3rgbErPr
         69vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btmbZscjcgDV6gMUkQqZSyJ7vtSOlzDWHe+5X4DPrdw=;
        b=U9bEPngd5FjusK3iDxRhCE3TzHZqu6kuUFOoebVD2BTSdf6jMbyxDAVj/gWyujYlCu
         rNzv5gul1x4/LYsA+fGtTN4cBgCEsGr2BhhaCvz6m+E8hSYwujdh1PXvIV1zepA3Fvlg
         yo0z+65uuOgrQxsJGaEQ/fZ9UEJ8rCxnNBMh6vqd1pVmLv8GskU9c+8/1suz6tp7wv3n
         CkjBvqe+bz1WKSaNTIx3gCtJWBqL9ZFRpV/YM+WMvR8qZLjklISPi19o9ysGirxSCxH8
         VkG0+0YdMeEgumkSrwi1maQi2isW3Yu2kgUWY422IqAToZ8Vo40LUAmChwVTVV5/IFvs
         Fb7g==
X-Gm-Message-State: ACrzQf2bDgZhlOiWpF1LspvvfFdnMSKKAzZ7PpHy470VYpDhV00gDeJN
        fdcpIE2fEt1KQ/n1ccZVl2eUGC/SdBwBdQ==
X-Google-Smtp-Source: AMsMyM5pE3mmaw6/qeuvRgKXiqRLQoNflp8hzJhkbKTQRR8UnRot0vmPPJr/W6bRjbZzjMAiiP9ILg==
X-Received: by 2002:a63:5063:0:b0:46e:cd36:ce0c with SMTP id q35-20020a635063000000b0046ecd36ce0cmr29196390pgl.617.1667528401459;
        Thu, 03 Nov 2022 19:20:01 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902e3d200b00187197c499asm1326816ple.164.2022.11.03.19.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 19:20:01 -0700 (PDT)
Date:   Thu, 3 Nov 2022 19:19:58 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andy Ren <andy.ren@getcruise.com>
Cc:     netdev@vger.kernel.org, richardbgobert@gmail.com,
        davem@davemloft.net, wsa+renesas@sang-engineering.com,
        edumazet@google.com, petrm@nvidia.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, andrew@lunn.ch,
        dsahern@gmail.com, sthemmin@microsoft.com, idosch@idosch.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH net-next] net/core: Allow live renaming when an
 interface is up
Message-ID: <20221103191958.2b9aa91e@hermes.local>
In-Reply-To: <20221103235847.3919772-1-andy.ren@getcruise.com>
References: <20221103235847.3919772-1-andy.ren@getcruise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Nov 2022 16:58:47 -0700
Andy Ren <andy.ren@getcruise.com> wrote:

> @@ -1691,7 +1690,6 @@ enum netdev_priv_flags {
>  	IFF_FAILOVER			= 1<<27,
>  	IFF_FAILOVER_SLAVE		= 1<<28,
>  	IFF_L3MDEV_RX_HANDLER		= 1<<29,
> -	IFF_LIVE_RENAME_OK		= 1<<30,
>  	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
>  	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
>  };

It helps with developers memory if you change the line to something like:
	/* was IFF_RENAME_OK */
