Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4F70FD76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjEXSFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjEXSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:05:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61862122;
        Wed, 24 May 2023 11:05:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so870315e9.0;
        Wed, 24 May 2023 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684951533; x=1687543533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDQRm84Nc6EHgMBi0uoHQy1EbdvJJMdPPoAechdeEGo=;
        b=nD09xgL0gBt2IymT9DkM4m7qDWcmXP3uDtqP3YJzoNh8Pk0DQgfkOMk2qngHkshflR
         iyt/ECrVsP2sibcq9WO91XiF5KHB74UYtCcuy9FgAlobhvYf6awu6ao/lhvzEPYqpLkd
         azxQB+yKyrJinI8QoEAcfcHjWahSH5cAaAU1h4FTHDIXmq9A24M2gzmNKGOC/1RDC+Rs
         1rc8Td64+BttaN36GwSaNF6Ii4INn8A8Sp1e30fzDkp0hBAepKgcU3W2SqLFtRwDs+br
         jCusXj6YBdtlj5dAEurPvFw3Tp9QT0zrJWu34eC+zcXTwsmH2YSHMSoXPSip/jmvy8S5
         kO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951533; x=1687543533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDQRm84Nc6EHgMBi0uoHQy1EbdvJJMdPPoAechdeEGo=;
        b=LerCBwOag6zFqmGMQgDJ4CudzdFVH0kIQWHHMtP9HhUZjtuRZevfwxnAqlrJuKk+N1
         WOnNYpAhrbzOa6c28SqfA43LEPwCC51wCns9G23NDtq8W1htGzQT8ObioKClqpwwLgBh
         nknFGQhtdm8quZalNDLXZd/EG5rDC7feZ5AMmrF9B10OnuJf1IJ0ZzUAyenPJqq8zZcR
         z4AfYW1c1gMd215KcV1oEI81M4RFBb/cCdqaYoBTjPw/oWDoR2WLTCqztOk7r8dMUicI
         /tksGkwpwiyJIh8qG2OrsBr+NmAj9cxChE/tdowoWDBIS1N/V3MHSIoDYVSBM1g+8q/w
         F7qg==
X-Gm-Message-State: AC+VfDxj13QgHEPI5jnSZ7UD9M3DX4DYy5eMSp/cTzVBf6Ybkvo+bind
        ydfshSwkVaxnd6qMJobwHjg=
X-Google-Smtp-Source: ACHHUZ40EUPJENiILINIaAhHJVMjtTSFNrL45/66eTCmqsyd1E2+esQwcvAEyUxRdFxnsSTZFKcQhw==
X-Received: by 2002:a05:6000:1049:b0:307:c0c4:1094 with SMTP id c9-20020a056000104900b00307c0c41094mr88713wrx.34.1684951532706;
        Wed, 24 May 2023 11:05:32 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6086000000b003064600cff9sm15197460wrt.38.2023.05.24.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 11:05:32 -0700 (PDT)
Date:   Wed, 24 May 2023 21:05:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 09/30] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
Message-ID: <20230524180529.y7vl5mb4rn4vwdhh@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-10-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522121532.86610-10-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:15:11PM +0300, arinc9.unal@gmail.com wrote:
>  	default:
> -		dev_err(ds->dev, "Unsupported p5_intf_sel %d\n",
> -			priv->p5_intf_sel);
> -		goto unlock_exit;

You could have probably left a comment though (that doesn't cost in
terms of compiled code):

		/* We never call mt7530_setup_port5() with P5_DISABLED */

> +		break;
>  	}
