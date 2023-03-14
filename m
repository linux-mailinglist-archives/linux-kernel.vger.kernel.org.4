Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A96BA020
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCNTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCNTzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:55:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19438031;
        Tue, 14 Mar 2023 12:54:59 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Pbkl465RTz49Q7F;
        Tue, 14 Mar 2023 21:54:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678823697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9JI+qty9Vz485GIKEV112iQoQGKC29JbO4+C01JJTY=;
        b=BMzKelRDsJwNeY5+RMJzEz5sxG6rWJ6WUYGQjwi5qbh+pHpzzpMCibujV3q7fayTsChbFA
        4Rdd9NiYFJ2nKd8xTnpQK/ZgddccphdFhXDpXzYFeSJfnc80JB6M/SsXgwlBcR/TMV0ALw
        j02zPUQ+XOjJIkDrrMWe7bEM29lhIR4/w7slJDeA2gXG7UuJyDYdwxbF2WoB76iCTUr8Q0
        EbSwWqaTJLvRNe7m8bfhIok2qccJ5CQ0I3WVp/XzBxGYbYt9ivibfzciF3O9F5BLmrL9+R
        zCHqXGU3GALjJqB07yNqoJmwWOGg7Nk13H/WcgCEtUOieBcY5ml+o2+aVl4UZw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678823697; a=rsa-sha256;
        cv=none;
        b=qjdEI+qPsgxQ/elLA4g/7kxzyvfwU2cnpLl8kEE5GdRniQ2oRLhq4eWvzqsEepgZXEBfGV
        KwAW7lVEJ6y3f8FFO87OxLimvJ4tOvKfLrhQr66+zKmo/hb7WjKHDSrvwMRktOi+rcfRfP
        oTnP689VzlgD/pMMbzGxm6JAYzVBINyk3/5Ssy7Cw377dCp7MV0+3Ii0SJCiAtMrOjX/q0
        KqThELJZw2eAgxXnE4D9hk3PM6++qcG8f1We5feLhdd9ziyc9uPf0/rbfpUkFJp+BSGMqP
        pz+p/UkYB9crhbMsIBcjVxU0BWA6KyOLhhI7pbG+k3YoghkTUk5d6AlMv3p/Tg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678823697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9JI+qty9Vz485GIKEV112iQoQGKC29JbO4+C01JJTY=;
        b=NWkUu8EbMK3joggOPH/zH13goyQhTZWBHy7q+EFw+mDVPg7c8KLeK5tv2N5RdQcHEzTI8z
        Mlr3ePAcbe828eAxFVnhfQHgERUWxEYcSIZ/CH4+T0iX2xUQ4V+uvN+c0c6hoAtjCFejYD
        dq9Y+6AaUslFxZaa0c+7Imq6df4kxV7YP5PncitCWlKD8gi+9jtUKNJ+Is8pqbnJ8q4bOT
        JT8yMZauhXY7HbrculBAzf/o7a15+GQnEb444h2DqKFAsv+PHPXaCYO02O/FN3CcPAJubK
        jZwXaBvH7p8n4Adlk6I2D9033D4ChK2vHQJDIJU/zTJmXgDDqRADnjJzb95PHQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 950AF634C91;
        Tue, 14 Mar 2023 21:53:53 +0200 (EET)
Date:   Tue, 14 Mar 2023 21:53:53 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Message-ID: <ZBDQ0YcBkYW3M/v0@valkosipuli.retiisi.eu>
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
 <2665862.mvXUDI8C0e@z3ntu.xyz>
 <ZBBh9Euor7R24euV@valkosipuli.retiisi.eu>
 <5654018.DvuYhMxLoT@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5654018.DvuYhMxLoT@z3ntu.xyz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 07:33:06PM +0100, Luca Weiss wrote:
> On Dienstag, 14. März 2023 13:00:52 CET Sakari Ailus wrote:
> > Hi Luca,
> > 
> > On Thu, Feb 09, 2023 at 05:46:48PM +0100, Luca Weiss wrote:
> > > +CC Helen Koike
> > > 
> > > On Montag, 6. Februar 2023 22:50:08 CET Rob Herring wrote:
> > > > On Mon, 06 Feb 2023 21:23:16 +0100, Luca Weiss wrote:
> > > > > Convert the text-based dt-bindings to yaml.
> > > > > 
> > > > > Changes from original txt:
> > > > > * Take wording for various properties from other yaml bindings, this
> > > > > 
> > > > >   removes e.g. volt amount from schema since it isn't really relevant
> > > > >   and the datasheet is a better source.
> > > > > 
> > > > > * Don't make reset-gpios a required property since it can be tied to
> > > > > 
> > > > >   DOVDD instead.
> > > > > 
> > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > ---
> > > > > 
> > > > >  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
> > > > >  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101
> > > > >  +++++++++++++++++++++ MAINTAINERS
> > > > >  
> > > > >  |   1 +
> > > > >  
> > > > >  3 files changed, 102 insertions(+), 41 deletions(-)
> > > > 
> > > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > > 
> > > > yamllint warnings/errors:
> > > > 
> > > > dtschema/dtc warnings/errors:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > medi a/rockchip-isp1.example.dtb: camera@3c: 'clocks' is a required
> > > > property From schema:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/i2c/ovti,ov2685.yaml
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/rockchip-isp1.example.dtb: camera@3c: 'clock-names' is a required
> > > > property From schema:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/i2c/ovti,ov2685.yaml
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/rockchip-isp1.example.dtb: camera@3c: 'dvdd-supply' is a required
> > > > property From schema:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/i2c/ovti,ov2685.yaml
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/rockchip-isp1.example.dtb: camera@3c: 'avdd-supply' is a required
> > > > property From schema:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/i2c/ovti,ov2685.yaml
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/rockchip-isp1.example.dtb: camera@3c: 'dovdd-supply' is a required
> > > > property From schema:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/
> > > > med
> > > > ia/i2c/ovti,ov2685.yaml
> > > 
> > > Looks like rockchip-isp1.yaml uses very incomplete sensor examples in
> > > their
> > > binding example, which sort of makes sense since those bindings are
> > > showing
> > > the rockchip isp bindings and contain the bare minimum to show how a
> > > sensor is connected in dt.
> > > 
> > > Not sure how to solve this - ov2685 is also one of three sensors that are
> > > used very abbreviated there.
> > 
> > Could these regulators be simply made optional?
> 
> Sure, from driver side it would just get dummy regulators instead.
> 
> Still the clocks are also missing in this rockchip example. Any suggestion 
> what to do about those?
> 
> Honestly I don't want to spend too much time on some ISP docs that I don't 
> really care about, would be nice if the maintainers of that could do that...

Ah, I think I missed this was about examples only, not actual DT source.

I guess you could just make up some clocks in that case? :-)

-- 
Sakari Ailus
