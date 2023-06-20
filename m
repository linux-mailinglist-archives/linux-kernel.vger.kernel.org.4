Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2D736E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjFTOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjFTOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:00:14 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA4E60;
        Tue, 20 Jun 2023 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=8SIpAWwEXWh+2s4C9M/ZFMOhqkGOD4GJqdqOvJ/wEc4=; b=wa
        o+769JSs2dCeQkSQKZ75nrAIJ5JwjvsRnNbk/7Okb8A9zJwNxCjJ8oaAXa/Ah2Hf/c4thvdTjBk1J
        FqatkyncShBoaYqnkp1k5+tfPJ17j7T60QMtOKbOBN0eUThvTO5/Xm108WvHMfMLg9PwiQS80rlNJ
        OD5Ak+wpBR+aQig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBbID-00Gzyr-OC; Tue, 20 Jun 2023 15:21:09 +0200
Date:   Tue, 20 Jun 2023 15:21:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/3] leds: trigger: netdev: expose hw_control
 status via sysfs
Message-ID: <71dfdbf0-09a3-4079-954f-cb87fe9b1817@lunn.ch>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-4-ansuelsmth@gmail.com>
 <CAH-L+nO12Gn4OGepr7KcCjLzMmisNYjYbFp13Aqu2Q14Rc77RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nO12Gn4OGepr7KcCjLzMmisNYjYbFp13Aqu2Q14Rc77RA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>     +static ssize_t hw_control_show(struct device *dev,
>     +                              struct device_attribute *attr, char *buf)
>     +{
>     +       struct led_netdev_data *trigger_data = led_trigger_get_drvdata
>     (dev);
>     +
>     +       return sprintf(buf, "%d\n", trigger_data->hw_control);
> 
> [Kalesh]: How about using sysfs_emit? 

Currently, there are zero instances of sysfs_emit() in ledtrig-netdev,
and in any files in drivers/leds/trigger/, or even drivers/leds.

So i think it would be better to keep this consistent with the rest of
the code in this file, and have a follow up patchset which reviews and
converts the 52 sprintf() in drivers/leds.

	 Andrew
