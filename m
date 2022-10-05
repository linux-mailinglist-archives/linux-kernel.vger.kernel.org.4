Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDF5F59C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJEST0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Oct 2022 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJESTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:19:20 -0400
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20217F27C;
        Wed,  5 Oct 2022 11:19:18 -0700 (PDT)
Received: from mail3.berkhan-weisser.de ([2a03:4000:54:b9a::4])
        by mail.inka.de with esmtpsa 
        id 1og8zE-001sH4-Ga; Wed, 05 Oct 2022 20:19:16 +0200
Received: from 127.0.0.1 (helo=localhost.localdomain)
        by mail3.berkhan-weisser.de with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <Enrik.Berkhan@inka.de>)
        id 1og8zE-00BKTP-4E; Wed, 05 Oct 2022 20:19:16 +0200
Message-ID: <6ebd7f9424e43c70af4ada9fe5bf616d1a112bcc.camel@inka.de>
Subject: Re: [PATCH v2 5/7] HID: ft260: improve i2c large reads performance
From:   Enrik Berkhan <Enrik.Berkhan@inka.de>
To:     Michael Zaidman <michael.zaidman@gmail.com>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Date:   Wed, 05 Oct 2022 20:19:15 +0200
In-Reply-To: <Yz2V+pT/2AmGvE7k@michael-VirtualBox>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
         <20220928144854.5580-6-michael.zaidman@gmail.com>
         <4ce2960686605f2290046b396a8edc4cc47beb9e.camel@inka.de>
         <Yz2V+pT/2AmGvE7k@michael-VirtualBox>
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

On Wed, 2022-10-05 at 17:34 +0300, Michael Zaidman wrote:
> On Tue, Oct 04, 2022 at 08:15:56PM +0200, Enrik Berkhan wrote:
> > As the ft260 can pack up to 60 bytes into one report, would it make
> > sense to use a multiple-of-60 size (120 or 180)? Might reduce overhead
> > by another tiny bit ...
> > 
> > Cheers,
> > Enrik
> > 
> The size of the Read IO to perform is given to the driver by the upper
> layer. So it's up to him how to align the IO request size.
> 
> When we read from the EEPROM, we want to issue the read requests with
> EEPROM page size granularity. The I2C EEPROMs page sizes are usually a
> power of 2 aligned.

Understood! I only thought about the HID report sizes. With EEPROMs
etc. in mind, it makes perfect sense to prefer power of 2 sizes.

Thanks for also providing the test results.

Cheers,
Enrik


