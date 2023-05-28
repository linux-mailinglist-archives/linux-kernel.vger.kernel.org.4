Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40527140F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjE1WYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjE1WYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:24:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5063B8;
        Sun, 28 May 2023 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=rzAHwEpFE6TgPMpIzYMZDH7mGCA9QmohOOuOlNQiIcw=; b=YqHzFAo8XTuTBYGdzfRa5HtXkD
        oyJHM0HX83RysJV8DyjyBDK3C5iUZV2pnZz4HUF1hwtnAyGrbB7TxkjPweJnaNuHiRrjwbl1LhEoU
        iY0JdGgWIHjqFv+sJ0r+DxdY2IeWW26LwP9/+qSEapPlCk6iuhC1hEkEeMKNdVjuoTJZujNrSEoA8
        Oj3ENTOvAh5zihhJ4mLDP5/MooomDD7qmZmD/ccfUhASdvCAOgJKtPQEv9LEZBQHbaFmUoXpb92d4
        eZuYSVaoieSf/vFqONz7cc2I6UEWjTO2vJI3G25JKaMmV2i56s37lb83RsDyFyUnSXzB65Aa/igtB
        HZela5lg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3OoP-008XH9-0h;
        Sun, 28 May 2023 22:24:29 +0000
Message-ID: <cc224b00-6f92-9d2e-0308-ae2a5c73236a@infradead.org>
Date:   Sun, 28 May 2023 15:24:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: scsi/stex time_after() build warnings
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <89df78d0-fb52-9045-2074-1d6f0afae4d9@infradead.org>
 <c86f90b4-458a-3066-4a8e-6e510a41a37d@acm.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c86f90b4-458a-3066-4a8e-6e510a41a37d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 5/28/23 13:30, Bart Van Assche wrote:
> On 5/27/23 16:08, Randy Dunlap wrote:
>> When I build stex.o for i386, I see these build warnings:
> 
> Are you perhaps using gcc 13?

Yes.

> Has the following alternative patch been considered? I think this patch is lower risk than the patch in the original email:
> 
> diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
> index 5b230e149c3d..8ffb75be99bc 100644
> --- a/drivers/scsi/stex.c
> +++ b/drivers/scsi/stex.c
> @@ -109,7 +109,9 @@ enum {
>      TASK_ATTRIBUTE_HEADOFQUEUE        = 0x1,
>      TASK_ATTRIBUTE_ORDERED            = 0x2,
>      TASK_ATTRIBUTE_ACA            = 0x4,
> +};
> 
> +enum {
>      SS_STS_NORMAL                = 0x80000000,
>      SS_STS_DONE                = 0x40000000,
>      SS_STS_HANDSHAKE            = 0x20000000,
> @@ -121,7 +123,9 @@ enum {
>      SS_I2H_REQUEST_RESET            = 0x2000,
> 
>      SS_MU_OPERATIONAL            = 0x80000000,
> +};
> 
> +enum {
>      STEX_CDB_LENGTH                = 16,
>      STATUS_VAR_LEN                = 128,
> 
> 

Yes, that also works. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
