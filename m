Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36571FB63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjFBHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E44123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 912CC60EE9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EF9C433D2;
        Fri,  2 Jun 2023 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685692435;
        bh=XH5l+kAhJj2RsYxYAcPm2mIoXZkoLae+HowrUKup1UQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AeNLt/fCvTQ0N19RKQBtqbYxgE6fQDZAzEj6n5CWmZQBpn69YD1RCefmkQi8VI1Te
         k92FEzgP6HyjFgmxz2zLhXrwKnMPbPzEBKy8dbQJwRfA0yGi0gbGW+9JjE7LsILOZz
         YxPYWJ1FEpu7ASvlR+9yVLUrx4QQc5EkUvgGlNGz3418QztSgdGQC0xTHdhcc/HrAa
         g3ZyD3ET5+dWyanokzuJGojr/C9NN1MNeXKAoEzHPZHejMpHAwA4Pu23E+9xa5h/Hz
         9KRy49AjnBpyix20mT02pjEpgU6pk+Jhee91zgxgCpiS1VwkOUziVGAcrgI3L2Oocn
         NzC41kU9ziCvQ==
Date:   Fri, 2 Jun 2023 09:53:49 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     msmulski2@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com,
        Michal Smulski <michal.smulski@ooma.com>
Subject: Re: [PATCH net-next v6 1/1] net: dsa: mv88e6xxx: implement USXGMII
 mode for mv88e6393x
Message-ID: <20230602095349.2ab53919@dellmb>
In-Reply-To: <20230602001705.2747-2-msmulski2@gmail.com>
References: <20230602001705.2747-1-msmulski2@gmail.com>
        <20230602001705.2747-2-msmulski2@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 17:17:04 -0700
msmulski2@gmail.com wrote:

>  				config->mac_capabilities |= MAC_5000FD |
>  					MAC_10000FD;
>  			}
> -			/* FIXME: USXGMII is not supported yet */
> -			/* __set_bit(PHY_INTERFACE_MODE_USXGMII, supported); */
> +			__set_bit(PHY_INTERFACE_MODE_USXGMII, supported);
>  		}
>  	}

The set_bit() should go into the if statement above, since 6361 does not support usxgmii:

 /* 6361 only supports up to 2500BaseX */
 if (!is_6361) {
 	__set_bit(PHY_INTERFACE_MODE_5GBASER, supported);
 	__set_bit(PHY_INTERFACE_MODE_10GBASER, supported);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII, supported);
 	config->mac_capabilities |= MAC_5000FD |
 		MAC_10000FD;
 }
-/* FIXME: USXGMII is not supported yet */
-/* __set_bit(PHY_INTERFACE_MODE_USXGMII, supported); */




Marek
