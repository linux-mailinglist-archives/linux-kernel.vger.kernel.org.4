Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC366892F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAMBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbjAMBcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:32:08 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8788BCEC;
        Thu, 12 Jan 2023 17:32:07 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so11560708oto.5;
        Thu, 12 Jan 2023 17:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fl+dQgFDOHnehs2ITo/nmS7u8hX/0iRdSWJRduyAIA=;
        b=0pKCl1+OZSv+gvtSZLb/3AAuVHLTnJ36Ia4Ue0RDpN2ZOEz811+GfVKs0RovyBW05y
         HJHs8ADG8DfAasPO8RqNrtFXfhV7yP/zQmUl+gi0X61Mj+clcJPIg9g8gci+OQtgMfOW
         FH7rHXIXX9dhLnSQxecVcV96kCdh+N97fsrTf3NnjvPoHqTGOOjdCvZAFmq4O1rqd5TB
         uLH3fOeAeZkvVzc2+HnFrq7/05pmKrEy+Af7WASXTiIaNtIofs7kNEVKQFeskHFy9I0n
         I7FStpIoPJGojqPrkVEMN2Ro3kKlF+eg4JK0+wXPpSpVYgE7spgICgr+7/r66iyvz1nr
         Zuyg==
X-Gm-Message-State: AFqh2kqLqehdHyISrNLECM/zd6/yFJo/rBCf+i0uYfGtXHksiUOLdtzl
        nmtkQDWoC6bX4m+29VAnRw==
X-Google-Smtp-Source: AMrXdXux7TjfK/p9O4zfaswoprC9n3HwjdB7E7cR7YzT/PblrisFh5R9M2PwmiABCZQjJ/Iovf1ujQ==
X-Received: by 2002:a9d:5904:0:b0:670:885e:f8ff with SMTP id t4-20020a9d5904000000b00670885ef8ffmr36547872oth.8.1673573526782;
        Thu, 12 Jan 2023 17:32:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a056830314900b0066dae8cf9a0sm9973706ots.50.2023.01.12.17.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 17:32:06 -0800 (PST)
Received: (nullmailer pid 592094 invoked by uid 1000);
        Fri, 13 Jan 2023 01:32:05 -0000
Date:   Thu, 12 Jan 2023 19:32:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Robert Marko <robimarko@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH] of: property: fix #nvmem-cell-cells parsing
Message-ID: <167357352392.592020.6790951746345716129.robh@kernel.org>
References: <20230110233056.3490942-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110233056.3490942-1-michael@walle.cc>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 00:30:56 +0100, Michael Walle wrote:
> Commit 67b8497f005f ("of: property: make #.*-cells optional for simple
> props") claims to make the cells-name property optional for simple
> properties, but changed the code for the wrong property, i.e. for
> DEFINE_SUFFIX_PROP(). Fix that.
> 
> Fixes: 67b8497f005f ("of: property: make #.*-cells optional for simple props")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/of/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks!
