Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC87355AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFSLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjFSLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:24:18 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14F113;
        Mon, 19 Jun 2023 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687173853;
  x=1718709853;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=xvY+pIKGlvC9vbdsC2zgnhbkr6gQbQo+dI+lcNkse3U=;
  b=FG2dtH1DCASR2LuN2ZFaRPq4IppRjKT3Mz9f4Al40FwAqKGLum/N2mil
   Fd7bYXDft7C5Q3/pNnky7x67zKaLLm2Dq1oSyngBDGV0vAipc18V3uwC4
   DHv0qmY0ex7KRW5ZQixOzdwOxGlENG+oi2yc45KYonwfCmnNJTmklpJQd
   hA+UV+aWtH9poUmn2l5swk9l81b3cDd9u9Psk55Imy835ofOwAV/hEMcl
   Sg7E2uV8+l/HbCWUL/pnXg+UVlplcupQKHq+IwKmjJdNRvhCU66MT7eza
   x6/xYMlecdlq1AY6EqNJHi3bi4RjI792GAEB6e9brjj3/XteZWUHJzyCC
   g==;
References: <cover.1686926857.git.waqarh@axis.com>
 <9487391b0565434761055b39ba04900bd839580a.1686926857.git.waqarh@axis.com>
 <20230617135532.328dc3c8@jic23-huawei>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <kernel@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <kernel@lists.axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add bindings for
 Murata IRS-D200
Date:   Mon, 19 Jun 2023 12:41:06 +0200
In-Reply-To: <20230617135532.328dc3c8@jic23-huawei>
Message-ID: <pndwmzz1yqu.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 13:55 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 16 Jun 2023 17:10:42 +0200
> Waqar Hameed <waqar.hameed@axis.com> wrote:
>
>> Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
>> for communication with interrupt support. Add devicetree bindings
>> requiring the compatible string, I2C slave address (reg) and interrupts.
>> 
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>
> This device will have some power supplies, so I'd expect those to be both
> listed and marked as required (maybe some are optional?)

Right, will add that here (and call `devm_regulator_get_enable()` in
driver's probe).

[...]

>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>
> If it is possible to remove interrupts from requires  - and hence have
> at least a partly functional driver doing basic reading of the sensor
> then that is usually a good idea.   Far too many board designers seem
> to decide that they don't need to wire up interrupt lines.
>
> If it's really hard then don't worry too much.

I see. It would be possible, but would also require some work. Let's
leave it for now then?
