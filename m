Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435D5B751F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiIMPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiIMPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:32:01 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8E7548A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:40:28 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bj14so21092557wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PSryuLt8d2S5NOnFQYaRkPd+ewmY9YOJjJlVlykIIBw=;
        b=PL6KQK4WAvTjNL4+2racF+mN5DenWrVgvTfKHYOm+TdmcOdBXajJDYGu389LYMga76
         oUHxjWLeSy9pbqbs2NWCLbFwPpAHiVTXhrc7QPnxKyrDCjUyqL35opweViGReRMLNghi
         Bw+KX6HO1tj+6pGtABPL2WSs7vcJaJ5qWQbQU2xeGWHyAh7PIxvR+zlDuuZzT8W3+srE
         hdboMRmbejnhTl8Nl6xaQsK3sWD2coMQIkTLhV6pGOgxuzJOoJ1v7luzQZSpvE6cT8DT
         gXMklK1wStxJaSEE95t3niygm91XlGX6v5/n0WFrglI0LZZnC3voDzTUaFlGqjPIVS8e
         twBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PSryuLt8d2S5NOnFQYaRkPd+ewmY9YOJjJlVlykIIBw=;
        b=dolv5kSxWlmR+zS5WrR2MQJ0lDT4M5Fh8dNd/NZ5xcf03OyFvW3RyV+oKLEKG1mkgB
         aYW+5EjeDRBvKhyjZjpXCCJuWPuaER90uwBWKbw+tHd/zV6Flq7V/MUJ9nIaWAVKYU4c
         E6P3/h3ev8kKcijHXu2a5KJxlWFim2JJewrsdrs9AkQ0XETVyBvS77yBGfzvgRG+lToL
         MuC8DiJrzAdXSBrRM3m4tawS4f6GPoSQJFIuXDf5CD2CTgunUgGDdH/l+YJ/MD1tN0hw
         9TychV0Om7aVzuLxUB1pNdEEDvLfI7bZhcjHdebQ+oPmIuYD/KUkgtXBYdsgi0Gi9sKG
         GwbQ==
X-Gm-Message-State: ACgBeo1QVFcfeqkVNsFEEs2hNlqMA8cr2k/fEjmhmfvzmmRCiVIM/YBH
        UmxmhE6Q57Wb+l9IHViVvHaBWw==
X-Google-Smtp-Source: AA6agR4xan9LcIemBd+CCIzPWBfolAoJH5FobI9T3VFcNGbSV5nwx/8YASJdkNc6pzosk4RDb4XfCw==
X-Received: by 2002:adf:e10c:0:b0:225:3168:c261 with SMTP id t12-20020adfe10c000000b002253168c261mr18279435wrz.159.1663079845811;
        Tue, 13 Sep 2022 07:37:25 -0700 (PDT)
Received: from localhost ([5.181.106.148])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b00228da845d4dsm10633337wrr.94.2022.09.13.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:37:24 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:37:23 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, kishon@ti.com, vkoul@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        zhangqing@rock-chips.com, jamie@jamieiles.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 01/11] dt-bindings: serial: rockchip: add
 rockchip,rk3128-uart
Message-ID: <YyCVo/kHpWTbGpvx@elm>
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <4f283231-2ed4-202b-0c23-157bce0841ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f283231-2ed4-202b-0c23-157bce0841ee@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 12:01:28AM +0200, Johan Jonker wrote:
> Add rockchip,rk3128-uart compatible string.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>
