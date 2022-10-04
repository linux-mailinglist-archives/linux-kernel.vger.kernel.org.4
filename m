Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423F5F491F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJDSQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJDSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:16:00 -0400
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CC1EAFE;
        Tue,  4 Oct 2022 11:15:59 -0700 (PDT)
Received: from mail3.berkhan-weisser.de ([2a03:4000:54:b9a::4])
        by mail.inka.de with esmtpsa 
        id 1ofmST-001Gj9-QH; Tue, 04 Oct 2022 20:15:57 +0200
Received: from 127.0.0.1 (helo=localhost.localdomain)
        by mail3.berkhan-weisser.de with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <Enrik.Berkhan@inka.de>)
        id 1ofmST-00AtOx-E9; Tue, 04 Oct 2022 20:15:57 +0200
Message-ID: <4ce2960686605f2290046b396a8edc4cc47beb9e.camel@inka.de>
Subject: Re: [PATCH v2 5/7] HID: ft260: improve i2c large reads performance
From:   Enrik Berkhan <Enrik.Berkhan@inka.de>
To:     Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Date:   Tue, 04 Oct 2022 20:15:56 +0200
In-Reply-To: <20220928144854.5580-6-michael.zaidman@gmail.com>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
         <20220928144854.5580-6-michael.zaidman@gmail.com>
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
> After:
> 
> $ sudo ./i2cperf -d 2 -o 2 -s 128 -r 0-0xff 13 0x51 -S
> 
>   Read block via i2ctransfer by chunks
>   -------------------------------------------------------------------
>   data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
>   -------------------------------------------------------------------
>   49316           85             256           2           128
> 
> Kernel log:
> 
> [  +1.447360] ft260_i2c_write_read: off 0x0 rlen 128 wlen 2
> [  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
> [  +0.001633] ft260_xfer_status: bus_status 0x41, clock 100
> [  +0.000190] ft260_xfer_status: bus_status 0x40, clock 100
> [  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 128 rlen 128 flag 0x7
> [  +0.008617] ft260_raw_event: i2c resp: rep 0xde len 60
> [  +0.008033] ft260_raw_event: i2c resp: rep 0xde len 60
> [  +0.000954] ft260_raw_event: i2c resp: rep 0xd1 len 8

As the ft260 can pack up to 60 bytes into one report, would it make
sense to use a multiple-of-60 size (120 or 180)? Might reduce overhead
by another tiny bit ...

Cheers,
Enrik


