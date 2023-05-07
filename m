Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0126F9807
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjEGJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjEGJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:34:51 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34BE14360;
        Sun,  7 May 2023 02:34:45 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 79B31240006;
        Sun,  7 May 2023 09:34:42 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 07 May 2023 11:34:42 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
In-Reply-To: <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <20230506141703.65605-2-contact@artur-rojek.eu>
 <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
Message-ID: <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 2023-05-07 10:39, John Paul Adrian Glaubitz wrote:
> On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
>> Squash two bugs introduced into said macros in 7f47c7189b3e, 
>> preventing
>> them from proper operation:
>> 1) Add DMAOR register offset into the address of the hw reg access,
>> 2) Correct a nasty typo in the DMAOR base calculation for
>>    `dmaor_write_reg`.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  arch/sh/drivers/dma/dma-sh.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/sh/drivers/dma/dma-sh.c 
>> b/arch/sh/drivers/dma/dma-sh.c
>> index 96c626c2cd0a..14c18ebda400 100644
>> --- a/arch/sh/drivers/dma/dma-sh.c
>> +++ b/arch/sh/drivers/dma/dma-sh.c
>> @@ -254,8 +254,11 @@ static int sh_dmac_get_dma_residue(struct 
>> dma_channel *chan)
>>   * DMAOR bases are broken out amongst channel groups. DMAOR0 manages
>>   * channels 0 - 5, DMAOR1 6 - 11 (optional).
>>   */
>> -#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n)*6))
>> -#define dmaor_write_reg(n, data)	__raw_writew(data, 
>> dma_find_base(n)*6)
>> +#define dmaor_read_reg(n)		__raw_readw(dma_find_base((n) * 6) + \
>> +						    DMAOR)
>> +#define dmaor_write_reg(n, data)	__raw_writew(data, \
>> +						     dma_find_base((n) * 6) + \
>> +						     DMAOR)
>> 
>>  static inline int dmaor_reset(int no)
>>  {
> 
> I have looked through the changes and the code and I agree that there 
> is a typo
> in dmaor_write_regn() that needs to be fixed and that the DMAOR offset
> is missing
> although I don't understand why that didn't break the kernel on other
> SuperH systems
> such as my SH-7785LCR evaluation board or the LANDISK board which Geert 
> uses.

I also wondered that. On SH7709 it's a hard panic, it should be the same
elsewhere.

> 
> What I also don't understand is the factor 6 the DMA channel number is
> multiplied
> with. When looking at the definition of dma_find_base(), it seems that
> every channel
> equal to 6 or higher will return SH_DMAC_BASE1 as DMA base address.
> But if we multiply
> the parameter with 6, this will apply to every n > 0. Is that correct?

As confusing as they look, those macros take dmaor index (a number in
range 0 <= n < NR_DMAOR) as parameter, then multiply it by 6 to convert
it to a format compatible with `dma_find_base` (which expects a channel
index). In practice `n` will be either 0 or 1, so dma_find_base(0 * 6)
will return SH_DMAC_BASE0, while dma_find_base(1 * 6) SH_DMAC_BASE1.

Cheers,
Artur

> 
> Adrian
