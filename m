Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F89739168
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFUVWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFUVWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:22:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75FE171C;
        Wed, 21 Jun 2023 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687382500; x=1687987300; i=w_armin@gmx.de;
 bh=nqz6wDOuZOw2af+Ib+ga1a707wJGiYWPr46WCAn/Trg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=h6nyphrNdOM72Ymmz/bwdng70so85do3ZQdFJjLG/PP6joomVvB/l486fpBklHeAG1MqvVR
 laiJxDfL7PyfjAvvS/SXph1S1JHBRj2deAEL37OMbKRQomwFhpPSm4vHqBkRNZKWZo/8HhjiU
 Q+NZJ9gCa3qy8oZfbsHj+seR46xHNoqcWAokHnOUPXTNzA6PLD95sueL/8XxVGC5ILzOxnEzw
 +fON4q60EcF7c0rWtn2FDDIeO26/1JHGuLTFs8lS0CDzwrIzrzvmljvVd4mdiyNjRDZmRT/wT
 Pgu2ClNVa5fXWOwcZlHDymDpeWTyZCICDoFEUVQhzU3UOylxsbIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1phxi60ebW-00oGzl; Wed, 21
 Jun 2023 23:21:40 +0200
Subject: Re: [PATCH v1 2/2] platform/x86: wmi: Replace open coded
 guid_parse_and_compare()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <20230621151155.78279-2-andriy.shevchenko@linux.intel.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <6f674805-b773-be24-4f27-1c86fbf1e3f6@gmx.de>
Date:   Wed, 21 Jun 2023 23:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230621151155.78279-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:oDUTZmCKOh3NS3NyhpBScJduSt8gPJHdZhBhoTTCn2CsVaG0IX3
 6tJoWC8Vyus8EGxaTdSKMrheNfl0ng54aqq89/4b27pSSGDJzOYuW6tZKZ3mTvF+E46Z59P
 USuaubL6Orkus/AjmhSjrBUlnOk08b86Ru7wNHGWzzkfnjRJqI9uHCEyldv2Doah2md1c6w
 pk8k9HKt8Mh63M7xaBpdw==
UI-OutboundReport: notjunk:1;M01:P0:wjKg/LMVlJ8=;l7r2+fyqhnXwj2RjoemiGCK/Hch
 6+YXKGUDDk7fiJJ2563J5W48O8koQGVhHNHZe1vtBBR/inymfpWPLI2JbRwOvtNUSlaeEyVp0
 Bh/ACylbmeEORR/WqYbDjHzqpkxPum++xSEeWVVsImJMg6b40MghvjLUtFVBqCAQS6W+XnisB
 i7pGXhT6MMZnTuXQI1m7clqMraTj8p+Jt6Xrq/3SxLJlxGXzwo+qiUppB75M4YkOfJ6J+erTr
 KB4xVeQt/N5iJ7t1Q4Pq12Hk7xSaTt/o04kEVgXSyaSMqYUb/5Kdkdvum7RhJPSJJKdpLD92p
 bVFs/oImgLTUEfosWlOQO4tu71RnOT33m4H0kARBknPjju24gxXn/Bsn7NlVfM7Bg3sCElu+a
 IMDKvx5QLXbOWhqIxE3Dtv64sqp7lZ9BuZdSrjeQRexH0760f1ZvpwA4Oa95Ms2L4eFVWys9r
 kIgQQqLdUrnbSwvQsgh3faXnR42mpUeDO8i5QilDYFjwL3WY6CDInq9xti2aLveoxXzUSOMkp
 2Y7eKl2bdBEPl5BIYFYR0JEsy3bCD58etr90ulqQBBfJzq6UN2bIuv4kb7P9Q+1F0LjkkQIVQ
 ScbLC+nPiy97kByC9Zo7BH2mLB2toJsoHy2wzWji5PaAHVSeNOEpFwBVzUMT5JgrMyJzRp9yd
 ybVQC8G0Ko4SlNqr7Z6zPWAftMtICzJdK3MwmKCOsYmNan1jYwyzN2n2gYlkDKfm7QFANy+kC
 wjHMj5fyfbkPiYPwtbfoQJutYlgKFNhPqMHXDZlcBTJhpXX45eMI2j+PhoUHIKlBf2NA0+hmi
 Tj3Gq/P7RplRbXDgUjGO4p1wQjd9cWTvkjL7n619QBIN2mWAuWcK6+urMlXdqn8ZRUY7RmrBW
 l3wy43EPC0C3gVr0JYEJuRh1dcU7+AXWaNaeKrj0jSxjCgheHi+ok9dWmly6B3eIaAh11CXb8
 qMPdSg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.06.23 um 17:11 schrieb Andy Shevchenko:

> Even though we have no issues in the code, let's replace the open
> coded guid_parse_and_compare().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/platform/x86/wmi.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 098512a53170..a78ddd83cda0 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1241,11 +1241,7 @@ static bool guid_already_parsed_for_legacy(struct acpi_device *device, const gui
>   	list_for_each_entry(wblock, &wmi_block_list, list) {
>   		/* skip warning and register if we know the driver will use struct wmi_driver */
>   		for (int i = 0; allow_duplicates[i] != NULL; i++) {
> -			guid_t tmp;
> -
> -			if (guid_parse(allow_duplicates[i], &tmp))
> -				continue;
> -			if (guid_equal(&tmp, guid))
> +			if (guid_parse_and_compare(allow_duplicates[i], guid))
>   				return false;
>   		}
>   		if (guid_equal(&wblock->gblock.guid, guid)) {

Works on my Dell Inspiron 3505, so for this patch:
Tested-by: Armin Wolf <W_Armin@gmx.de>

Armin Wolf

