Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D76693EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbjAMKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjAMKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:20:41 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C55745BB;
        Fri, 13 Jan 2023 02:20:37 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1135A9EF;
        Fri, 13 Jan 2023 11:20:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1673605235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/Sj+jw+5qCFtHhkImH+FMapResy0lqx5loXPf8lUMQ=;
        b=J2ZOwYby4ZZsBzpShYHvIHDWSKsgW+C180Vk2yMXZ9YQlqYsQ2bzJF2YMBWnLU+NWDPUbI
        Y6c+6W9YQkIsZ8g8o8IvN96lz6S3V+BhJHV6Q+G9VlqojDtXkrQbK6vu9tBT1JFh8aHo2U
        GEUgq3X0NIMmosjMcFubw6nTlxzDv2vN+9fUU1QCK0hjd3WFK/jsg5X79xEdOvesL3rI7q
        98iyYLnDtMihjdj6vcbg3JFOzLeqTg5Rbc/ukuXs2vrcGM/LbQ85jDj++Z4C6ilw7+++HV
        qwEgABscCDHOF+fSI7zzQpnEJud4grUHY5bz0Off4Ei0kCO6VzM2r6exAOSIEw==
MIME-Version: 1.0
Date:   Fri, 13 Jan 2023 11:20:34 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH] of: property: fix #nvmem-cell-cells parsing
In-Reply-To: <CAL_JsqLN0jd0nT7rC7SBMh2zLsAvGCafknnS_oqJJj+=c1m9pg@mail.gmail.com>
References: <20230110233056.3490942-1-michael@walle.cc>
 <167357352392.592020.6790951746345716129.robh@kernel.org>
 <CAL_JsqLN0jd0nT7rC7SBMh2zLsAvGCafknnS_oqJJj+=c1m9pg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <729fb97c96216168f73d1a7f01bfd70d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Commit 67b8497f005f ("of: property: make #.*-cells optional for simple
>> > props") claims to make the cells-name property optional for simple
>> > properties, but changed the code for the wrong property, i.e. for
>> > DEFINE_SUFFIX_PROP(). Fix that.
>> >
>> > Fixes: 67b8497f005f ("of: property: make #.*-cells optional for simple props")
>> > Reported-by: Peng Fan <peng.fan@nxp.com>
>> > Signed-off-by: Michael Walle <michael@walle.cc>
>> > Tested-by: Robert Marko <robimarko@gmail.com>
>> > ---
>> >  drivers/of/property.c | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> 
>> Applied, thanks!
> 
> Or not. 67b8497f005f is not in my tree, so
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks! Srinivas, can you pick it up to get rid of the errors/warnings
in linux-next?

-michael
