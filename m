Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B7716FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjE3VZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjE3VYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:24:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D310A;
        Tue, 30 May 2023 14:24:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso5587335b3a.1;
        Tue, 30 May 2023 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685481877; x=1688073877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lf4Z9YM584RxPxtekhg1O6Jg1+vKk3NS50lQs9HLET4=;
        b=SxPcpA0RkDSh6WW0LTYkjemKG5TpashrZVstG+xtYM3+f23QmPJE23JMDI5tPMu9Gd
         pH1zPJwBss/pHu6VYOU0GVespUNX3d77fVQ1o/BatEok/5gm8MYjBqask0J7H+AzgOYn
         1r7UBzv4H1BFY61jq2T77bzP9p6Yt9wzQ/3QK57EwqOfw2hCH9YwbPZNPtGmacamK65m
         3e0W6UibP62f3n6YUbgIb4Btcye3SVr7G4ZYObHCx0ZDV/82lpZTNmU6lkf+vdpIA6CV
         wTJnDx2S2lRhOhQSt9K0njHLo9lW5Hu8YAKX+Jzbp74C3n5NRAIRUxeLFK6OL6DCRhi6
         Tjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685481877; x=1688073877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lf4Z9YM584RxPxtekhg1O6Jg1+vKk3NS50lQs9HLET4=;
        b=Rjzv98+VN8M673B0PLfv1511K8nB6RIho+EKW1Ttj4fkZdXMLU3Pzvl+09kRO0gaHQ
         BnKCuMD4ZuXRd7lEYcnhDX3APhGi6DGj7jIg6FdkEDxgyrFTc9omCif59ni2tYMCXn9N
         3Hz7I7xZB2i8pVCgOXikzfpVDNFcJfKV1eJOnG4uM/CJTpylJ6bryG4NL6ShLvW4ZmB+
         QS1cqI6KVnN0BGTfwLeob41+UsNAVHW+MrXumTQxjK7XMCTf6u0UnLS7rQA9fHt5MiKM
         2lPxQmJM7n6vUJlUTd6uywil1UsgJwmaCzygMup0N2HU4vAzkBKMUOrx8kACoWCIv0ak
         aSYw==
X-Gm-Message-State: AC+VfDwAOkPdjcT9nLGAVGmtNa6O4Yfs8zghob9JYqPJ6apIJddsE51q
        BQMfLlwkxgfs10Fec/+dh0c=
X-Google-Smtp-Source: ACHHUZ5FdDfHq5uzHHtqc3wO2ef3hvpWGLBPKVLe1B1D8eGU1Bwp2L78yxgx9QztJNICOVd5caoh5Q==
X-Received: by 2002:a05:6a00:9a0:b0:63b:8eeb:77b8 with SMTP id u32-20020a056a0009a000b0063b8eeb77b8mr4227571pfg.13.1685481876642;
        Tue, 30 May 2023 14:24:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7987:7b1c:51b:39d1])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0064d413ca7desm2111649pfn.171.2023.05.30.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:24:35 -0700 (PDT)
Date:   Tue, 30 May 2023 14:24:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        hsinyi@google.com, jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org
Subject: Re: [v2 1/2] HID: i2c-hid: elan: Add ili9882t timing
Message-ID: <ZHZpkGYYkYK4SrHX@google.com>
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
 <20230520050649.2494497-2-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Xpe=zOeq2pG17Q0n_SZZHAFmaE+6C=SnuHqnHN6uObog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Xpe=zOeq2pG17Q0n_SZZHAFmaE+6C=SnuHqnHN6uObog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:27:38AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, May 19, 2023 at 10:07 PM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The ili9882t is a TDDI IC ((Touch with Display Driver)). It requires the
> > panel reset gpio to be high before i2c commands. Use a longer delay in
> > post_power_delay_ms to ensure the poweron sequence.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> This seems OK to me. The one thing I'd also do is to update the
> Kconfig description to say that this driver is also used for Ilitek. I
> think it's fine to keep the symbol name as I2C_HID_OF_ELAN but just
> change the description.

Does ilitek have the same set of regulators, etc, or is it only the
timing? I'd probably make it a separate mini-driver...

Thanks.

-- 
Dmitry
