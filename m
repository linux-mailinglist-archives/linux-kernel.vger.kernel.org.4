Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253B3739164
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFUVVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFUVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:21:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E5197;
        Wed, 21 Jun 2023 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687382405; x=1687987205; i=w_armin@gmx.de;
 bh=0hPRe6Jjh6LOOGIR6mNfOCZv6nV888ENDXtBJB1e2O8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=i1is1Jjw7bOo+qVLjDNsYsrtT1OD0P9Pv4wUIL3f+Ik4zc0j9vjsg5WGyjD1j/y4Nga8Uvr
 pBAT9QeXWszHe6oZQvK4qXHCEWcTJPJ0eoYFYpdd95ul+BPNVP6gekENqMgQsGU5OLZsNdayw
 DvnCnkDTq8kk2S6EngOuDjgH22AVnNMheEfisAgqILzHz+1KiocRJodL4VM90+AfATERrycPE
 BQzQAcS3cxGLYTDA1ST/jT90ADmVSb1ZsoRPvbZQDs7fPkFuqkrC0pZnvi0gqnOwJQwca7ChQ
 6J2hJmg87A8bYQ+DT+q4nPIVWPPgkR5nE0J96RAuSJ4YCBhwJzKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1qeZQr3Bou-00Sc08; Wed, 21
 Jun 2023 23:20:05 +0200
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
Date:   Wed, 21 Jun 2023 23:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:Hk1yYUVhf/qoQ320NHe1eZ617rBal+Bp3byNlCH6RwaZyu8k8Bz
 NCuU/85C4vJj2O2j+VXhRNu2icXxv7i5EQn5g+VJQJSFUwAx/ZESAMbWJx9beCz5UdFM9YF
 MYwT6RdbKT0T68xPsAS2v90Vl4LSszd59UpHq7b7g8T3M6jkQU+F1E/JZbUIiByknUjxQG7
 nHpKCbMLU2uDtXSi7BT2Q==
UI-OutboundReport: notjunk:1;M01:P0:k2ofq5X6SY4=;CtkAgbGbtP9hxnnTmkyHWSMuqlY
 rCkNdS4vNYfIzBGWsrziR8tTZj6vt/flhj8vR/Xj/ChikN2u+RZ6bqVbpdlqkFLbEznDf4VNh
 hwYeSF110dJZ24R5PLDCoERP3QxCLJ4i6foKFhJqz5DYBypx2jwC3wOeW3+rpy977OlLkcOnS
 nUZAOtWzbO/3AVmV6JpPU7sIVP2uKj1dSeLx8H+rMAO7P1CEsFk7gSvY6Ow82x9zhKWAKljd9
 FkmMpeyqcRFZrGnfHRyyBakA8yO10DpDlVcmWNpCl+Ttivf9a9Ru8O3qETrG2qGsKfgwkh5oh
 ceFuKv2eKkQxP1Lvn85bXs0k+8Q8IrwfTwotjP0T1RlH9Ozjuq7wH/dRODzIOU0TrqXdflOX9
 zjkHmDnxCIyam3YHam3MCOUohjk6yFjJOAjeDGbLNGhKqYM74uen545QN5Ol+Ho1xrp0Dkctl
 vJTX8q+pr3duSJ2W1j/as1UwRpYLeBxK5uff0kFUGMiLXvDtQX4R1JtqkXHdcaLJjkRz74Wt3
 1cIXBGmhBmTqzRGw2eWZRt3gn36zfepzs1SeN2seeqICIX7rzAeNVGzs6TCLehlhaAxmln+nu
 KSxc+2Bu3TlL1a1Obd1E68QQAokqBdG7OUX5ssF7zbIVGIxDPsq7yC1Bx9pcSjfrs2XQxfEvx
 N5hCQkLHe885V1S1Mp462xGXJ/BnxP4YWqYxytC9XQHv8w90JCWUAg3824VxxODa+kEtOB3dm
 08Nt5YaiDAWlcj5+8SQeHLwSAPaLOLV47lVmN4UqKOg6dFs4hhZ0pwQgdoKSY0NVL3lnMMfxH
 z7blCzvoRRNLPsxoa20zijM8g68qzuEJH8E0nQWthD/1keZ+mPYFlWjmSsj/iT6L6rw4MwQmY
 LaD7UkS95oY+A2bxJaNFz7WTqK1Ch0DK4aiOwDxaoiVLMJzkCPmvQvVZmPHwuqJvIXqtHMaJb
 ZkTzaUjt4r8DqX2o4uWNyv0A5XM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.06.23 um 17:11 schrieb Andy Shevchenko:

> The while-loop may break on one of the two conditions, either ID string
> is empty or GUID matches. The second one, may never be reached if the
> parsed string is not correct GUID. In such a case the loop will never
> advance to check the next ID.
>
> Break possible infinite loop by factoring out guid_parse_and_compare()
> helper which may be moved to the generic header for everyone later on
> and preventing from similar mistake in the future.
>
> Interestingly that firstly it appeared when WMI was turned into a bus
> driver, but later when duplicated GUIDs were checked, the while-loop
> has been replaced by for-loop and hence no mistake made again.
>
> Fixes: a48e23385fcf ("platform/x86: wmi: add context pointer field to st=
ruct wmi_device_id")
> Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/platform/x86/wmi.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 5b95d7aa5c2f..098512a53170 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -136,6 +136,16 @@ static acpi_status find_guid(const char *guid_strin=
g, struct wmi_block **out)
>   	return AE_NOT_FOUND;
>   }
>
> +static bool guid_parse_and_compare(const char *string, const guid_t *gu=
id)
> +{
> +	guid_t guid_input;
> +
> +	if (guid_parse(string, &guid_input))
> +		return false;
> +
> +	return guid_equal(&guid_input, guid);
> +}
> +
>   static const void *find_guid_context(struct wmi_block *wblock,
>   				     struct wmi_driver *wdriver)
>   {
> @@ -146,11 +156,7 @@ static const void *find_guid_context(struct wmi_blo=
ck *wblock,
>   		return NULL;
>
>   	while (*id->guid_string) {
> -		guid_t guid_input;
> -
> -		if (guid_parse(id->guid_string, &guid_input))
> -			continue;
> -		if (guid_equal(&wblock->gblock.guid, &guid_input))
> +		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
>   			return id->context;
>   		id++;
>   	}
> @@ -895,11 +901,7 @@ static int wmi_dev_match(struct device *dev, struct=
 device_driver *driver)
>   		return 0;
>
>   	while (*id->guid_string) {
> -		guid_t driver_guid;
> -
> -		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))

Hi,

just an idea: how about printing an error/debug message in case of an malf=
ormed GUID?
This could be useful when searching for typos in GUIDs used by WMI drivers=
.

> -			continue;
> -		if (guid_equal(&driver_guid, &wblock->gblock.guid))
> +		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
>   			return 1;
>
>   		id++;

Works on my Dell Inspiron 3505, so for this patch:
Tested-by: Armin Wolf <W_Armin@gmx.de>

Armin Wolf

