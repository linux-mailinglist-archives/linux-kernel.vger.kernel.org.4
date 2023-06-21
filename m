Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88F7391CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFUVvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFUVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:51:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EFCFC;
        Wed, 21 Jun 2023 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687384253; x=1687989053; i=w_armin@gmx.de;
 bh=6Xmv7vD6eiYx1sPenoCtuNkZHGz8aSPHMuGO9T/g0Sk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=NhriHbVw+FOYLlhhG6uLZ/MSQ5CT14SYwbWSdD+PjNlGyuW75thcR9Ux7qdvFxoWKoPG5wl
 broNgCkD3q1AOcFiXhiBsKTMIqE362qzBPTxo+r5DiUaK7nM5e4RjAS7AS3NrvsU0hX5kkBmI
 q2x6vf6vLR77F8gm3eZYJ2kRhP0vEWwUoXpmc47NTHmfhSsBBUh6i7/LpjZYSlissWHz/71i9
 sYgQapcU7It57IdLqc+i/ON2356yNfFOQdllaj6VlKkUrsYG9N3X6qN9A2QTqHKb0tSupgkxr
 9rGAft5Sq9lvwCqHhYafl0KUCyDj9r4kll4A3BlGhHPPiUWu7F6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1ps4vc163F-00xqAh; Wed, 21
 Jun 2023 23:50:53 +0200
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
 <25715979-8148-8d1d-fd67-a973661f9781@gmx.de>
 <TnTqU2wwXh3DG07kYUwMAe0hdBiaKiuoMOqBCBIttT27lXdw-KZVV8fZ7x-Zrg_Ux8mJUHClgyFHRbDoCRmhaOI7GwOPhUPYBRLzThV8iYI=@protonmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <b4dc2571-1163-805a-f92b-30dcc8b69246@gmx.de>
Date:   Wed, 21 Jun 2023 23:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <TnTqU2wwXh3DG07kYUwMAe0hdBiaKiuoMOqBCBIttT27lXdw-KZVV8fZ7x-Zrg_Ux8mJUHClgyFHRbDoCRmhaOI7GwOPhUPYBRLzThV8iYI=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:XHfB6/2Fw6zz+QB/CB9tZ0O8zinCxxSfWML+9No86ri+yX0CoJH
 G5idFR+azcQWZ49WEUGsJZkps+ALNG78sxxKGKiB/iqO1E+Zuy0gzQHy2N1qkQLsIwP/2N+
 e6GQXKiCaacTZ3PzdkLuvmQ+LI89oO8YkPml5pUvDRXZVfG9nCxMgPLqmAGNlA4cpIcmoDx
 ODdrKzCsCL6n5Vq5gT8Yg==
UI-OutboundReport: notjunk:1;M01:P0:kiMdPi8m4vc=;LCPJhRcRzh4tDsBZEYMWbKcawvc
 2G7UekStaOwsb3virvIbfMVyyr4587Vjk18g53vJPa8LGW3HeiLFuRmnJGXP46I7iOk4X96As
 VLYLG8oZxNdP66mjiwtNbTP77Ishh8sJspEh9pBWDwkVh2/Y0A9FXz9DubvIdQ20inijoCvI1
 RuWB96ocDCjOHI4q6NqKw+HCWjVZaM5DWD+gjuyxA2nAaeksurii4hDLelCgCi2/xl9WJr4O2
 ZOHaGuesSYPBhkJzJ0XpMAOQRNg2/lwMMavp+QYzO52maIcbpNmaVEyvYMlSozXjqOqBgjuWf
 xICy9qJVP59HftGEpGoPLelnqHCAoXe31Z2TTzSBXYXP5y91Ai8SWCVynS7LErD18sGsLOk7T
 OlU3qT4egReVD16Szi+Sp0H28rP1P8F9HZTK8JKWFtjXjjOZi4xEEVqtUGAWdFJgZKsZDymph
 S55+tQmMQrkGUhdOczruxcOq4QZjw8CIcbPFvLxOpR+L1QYjeTJEuPRmQ4m5QUmi8rUH96vLJ
 h1ElvdVrsQWDcDWPMrXk0PfMlPnUm02v2D0D0dgQD4Y6Q1qy3Ro64dcPLEvZaQqGG7Nl/am4w
 kphyrynbEr6Eh/T8EptWhyjBbnGWwSdYt4l/UldCusNQjj/SOuTJC6i9Ftkgur2BWqSLolfUH
 p0QDRql93xSM78KsVKTIb+7yaqTblTYruDI3JfOncyLKGDbHdTB6ZxdxOzvZSDhRkq7929Ygo
 hL11twN/Ug7v4ZcZ661n5AUqzvuwSaoHTQB2MVgLxxOxxJ8t13gsrXK+MRuyGBK9harjKiI8b
 uEQVffJuaGKGNz0ETMdpIpl7PTh6MqRksBWkSCa2marHAd1Uole9/eLp+tQwDPx9nPFV3O1G9
 Lfj1rgaVj6iNDudsyIVqPJHaezrbHOpqnuJiWSdSFMDO+jA8TCkJeXoiKBELLTivizzLRa7cN
 a81KvNuOuI0eMDRAvdkuvsftlqY=
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

Am 21.06.23 um 23:29 schrieb Barnab=C3=A1s P=C5=91cze:

> Hi
>
>
> 2023. j=C3=BAnius 21., szerda 23:20 keltez=C3=A9ssel, Armin Wolf <W_Armi=
n@gmx.de> =C3=ADrta:
>
>> [...]
>>> @@ -895,11 +901,7 @@ static int wmi_dev_match(struct device *dev, stru=
ct device_driver *driver)
>>>    		return 0;
>>>
>>>    	while (*id->guid_string) {
>>> -		guid_t driver_guid;
>>> -
>>> -		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
>> Hi,
>>
>> just an idea: how about printing an error/debug message in case of an m=
alformed GUID?
>> This could be useful when searching for typos in GUIDs used by WMI driv=
ers.
>> [...]
> Wouldn't it be better to change `__wmi_driver_register()` to check that?
>
>
> Regards,
> Barnab=C3=A1s P=C5=91cze

Good point, i guess we can just forget this idea. The original motivation =
for it was the WARN_ON()
inside wmi_dev_match(), but your right that this is the wrong place to che=
ck the GUID formating.

Armin Wolf

