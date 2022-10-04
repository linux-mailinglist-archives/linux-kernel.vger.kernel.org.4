Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302805F4914
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJDSLr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:11:43 -0400
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DAA3ED7F;
        Tue,  4 Oct 2022 11:11:41 -0700 (PDT)
Received: from mail3.berkhan-weisser.de ([2a03:4000:54:b9a::4])
        by mail.inka.de with esmtpsa 
        id 1ofmOJ-001GcI-9T; Tue, 04 Oct 2022 20:11:39 +0200
Received: from 127.0.0.1 (helo=localhost.localdomain)
        by mail3.berkhan-weisser.de with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <Enrik.Berkhan@inka.de>)
        id 1ofmOI-00AtIc-TP; Tue, 04 Oct 2022 20:11:38 +0200
Message-ID: <28932c5e2250c68e07ef5fafe3bee42653fd62f5.camel@inka.de>
Subject: Re: [PATCH v2 4/7] HID: ft260: support i2c reads greater than HID
 report size
From:   Enrik Berkhan <Enrik.Berkhan@inka.de>
To:     Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Date:   Tue, 04 Oct 2022 20:11:37 +0200
In-Reply-To: <20220928144854.5580-5-michael.zaidman@gmail.com>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
         <20220928144854.5580-5-michael.zaidman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, 2022-09-28 at 17:48 +0300, Michael Zaidman wrote:
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index bfda5b191a3a..cb8f1782d1f0 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -460,49 +460,68 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
>  static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
>  			  u16 len, u8 flag)
>  {
> +	u16 rd_len;
> +	int timeout, ret;
>  	struct ft260_i2c_read_request_report rep;
>  	struct hid_device *hdev = dev->hdev;
> -	int timeout;
> -	int ret;
> +	bool first = true;
>  
> -	if (len > FT260_RD_DATA_MAX) {
> -		hid_err(hdev, "%s: unsupported rd len: %d\n", __func__, len);
> -		return -EINVAL;
> -	}
> +	do {
> +		if (first) {
> +			if (flag & FT260_FLAG_START_REPEATED)

I think the test should be

    if ((flag & FT260_FLAG_START_REPEATED) == FT260_FLAG_START_REPEATED)

Otherwise, flag will never be FT260_FLAG_START ( = 2), as
FT260_FLAG_START_REPEATED (= 3) has tow bits set. It looks as if bit 0
actually means "repeated", bit 1 is "start" and bit 2 is "stop".

Cheers,
Enrik


