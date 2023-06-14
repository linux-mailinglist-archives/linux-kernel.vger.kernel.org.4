Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A746972F3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbjFNEuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbjFNEtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:49:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128CE1BDA;
        Tue, 13 Jun 2023 21:49:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6666b89ffaeso7006b3a.1;
        Tue, 13 Jun 2023 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686718186; x=1689310186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2bOk4R1NepPNFBwDvNUahQEGtGsBtFkPcwg9R+k3TQ=;
        b=JNl9OPt2dRoQrG2iUdxlAZawfZUMpP/ZsEla+fPkDihi+DWW2zVZYiEFqYnYcAR0L7
         vhSjaBsNZbKUVgFGhKg2sFbM0e2Xn1F2kS+r7AzQPftCPBMKt1nYWxXrkvUkAP4IDsxO
         EEnhjiETEyiNSO/IqD3X41HA0rwAjh8EayIzMr8Pcd6E1jAufReRfWbnP4O9MDmjkhpb
         OHGTuQzapAXFFq+Wa1dQhL+0sV40j/Wzo5vkv+CtUE+BGRmjmhfZpe5GrmGg5WjODr5f
         F9QoLbTWnfeVy4+fifJtTAO7hhxSus3yg/N4CrjSs/ulIluqBEY9FJ7c+5H/Oe6rdQNw
         1gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718186; x=1689310186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2bOk4R1NepPNFBwDvNUahQEGtGsBtFkPcwg9R+k3TQ=;
        b=l3jVWPXBtRTOjXqvuXooFXhnusRulmhqA8NXIe7FPQZ5wvFm0/GfjbbTtTJu/JOqR8
         gu7qoDqabcU4tQ+oeHeU0dOcjsERVtFT2eL5k3AI2UYQj1qOuEJ+MGOj9qazXMCQ21lL
         FBVv6wNMe3yodq/gL4p/7jbPn7fwmEU+Kanpi0GEjf++ByQpFYjr1GEBLn1XnoVsDtFR
         sIKPur0MdkBqeKDzWjvcdVxN7HohgRNwgYQecW8RSY2jkQ/eb3P4QWnM+Z3ePn8AqGkV
         VX1W1FxMJBZd7M2Acf1/CvXD25ZA6r24wuGKQKKEX16IwEnds7vxPcXgj6A7RYQ6H2xs
         mMYA==
X-Gm-Message-State: AC+VfDyN5NVlBWxWRnlS6Vt0l/6+BhEkXIiObf9mxYgxCqj4arI9Bl2b
        E7eG/jtlsxqtqYdVLYwHefg=
X-Google-Smtp-Source: ACHHUZ6R0k9M0NnQwTsbdDJv7NzcZtrEeKsxx/WftQzVqV36MPH9Xhk6d3AZwD9BLP9W+Pn2aO5hDA==
X-Received: by 2002:a17:903:41c2:b0:1b3:d8ac:8db3 with SMTP id u2-20020a17090341c200b001b3d8ac8db3mr7206982ple.6.1686718186520;
        Tue, 13 Jun 2023 21:49:46 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8200:e:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b001b3be6c08adsm5848333plg.282.2023.06.13.21.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:49:45 -0700 (PDT)
Date:   Tue, 13 Jun 2023 21:49:38 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] net: micrel: Schedule work to read
 seconds for lan8841
Message-ID: <ZIlG4otXfQ7uhMsc@hoboy.vegasvil.org>
References: <20230613094526.69532-1-horatiu.vultur@microchip.com>
 <20230613094526.69532-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094526.69532-3-horatiu.vultur@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:45:26AM +0200, Horatiu Vultur wrote:
> @@ -3840,6 +3847,12 @@ static void lan8841_ptp_enable_processing(struct kszphy_ptp_priv *ptp_priv,
>  			       LAN8841_PTP_INSERT_TS_32BIT,
>  			       LAN8841_PTP_INSERT_TS_EN |
>  			       LAN8841_PTP_INSERT_TS_32BIT);
> +
> +		/* Schedule the work to read the seconds, which will be used in
> +		 * the received timestamp
> +		 */
> +		schedule_delayed_work(&ptp_priv->seconds_work,
> +				      nsecs_to_jiffies(LAN8841_GET_SEC_LTC_DELAY));

Why not do this in the PTP kworker thread?

The thread's scheduling can be easily tuned with chrt to give it
appropriate priority, but work can't.

Also, If you have seconds thread, then you don't have to defer the
received frames.

Thanks,
Richard
