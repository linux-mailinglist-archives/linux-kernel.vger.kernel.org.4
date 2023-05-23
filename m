Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC77E70DAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbjEWKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEWKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4EFD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684839159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRwLpBjF3y771Oa2kRIVwXk75u6DRLRrsAa1LNU04Go=;
        b=a4KlVZ+HIcYMT57oa2hIkwLI28nSkcONROtDIegUThIIEP0vRmGWgXbNjDd+Px6xir/MfQ
        wipvVOrKAEocmZaSIXhox9lTgJIIx7GmZmJqn3fGerBqrSXmUQ+StFWhOOoEPVfPG8RkJu
        JEdC80AhRBo4sJF2iVbmEXj3/XD5CSI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-P4dT9dHEO5me3MiiCxTciA-1; Tue, 23 May 2023 06:52:36 -0400
X-MC-Unique: P4dT9dHEO5me3MiiCxTciA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96fb396ee3dso297993366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839155; x=1687431155;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRwLpBjF3y771Oa2kRIVwXk75u6DRLRrsAa1LNU04Go=;
        b=cBOlzpg48hXdIjASBGJUj38yFu8kLdJTOgOgUhw5CSJ37eu9Sj0k2CJFYz98IleFQi
         NJGhzQxUdBaLOq3HprNAnt4ApenWfNkQHKeVa2S/hKmSq9YCGHQvl8y+USbIF5C1KtQ5
         Es9m93zlCtdogQ2HyV/31UvfQedHj0SL3j4FoZUGLk2fPhAnWw8joj5aU8leTAcFf8gW
         sDje4kwRzZ+vWR0MA5fKd4CxhwIMjeaJsnPMe3ThA64ddvPm5PgkzMxKCvaS8kH9KalT
         L1XkfB9vS1dk2aCaSY5P8Mabwxe8Hp3TdCIXeHBvT+Tz5u4AghrRRa3x0JaNXDYVhoO/
         zezw==
X-Gm-Message-State: AC+VfDwKotF9gFUc6OHQLKMpYfrb6xSL9ZGrhBow+JyRqKgNGKpF8EUh
        mp99sMWud49UrGTb1zX0jVzw2lDSdVmXQY3+dNfDHPL0mc4flg70pBCvi1j/bbimF0aRkqzKoIR
        stIXtZaEvQW2mYjcs2LT7Zq4E
X-Received: by 2002:a17:907:8a03:b0:96f:912e:5ec4 with SMTP id sc3-20020a1709078a0300b0096f912e5ec4mr11425489ejc.16.1684839155030;
        Tue, 23 May 2023 03:52:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Nbl1Vghh5ZdHqZZ5iGGQDxRmXaZZtG9X7gxBAsJ5YfMawF4xYsFX55IGJIy3Jewaqh9qB7Q==
X-Received: by 2002:a17:907:8a03:b0:96f:912e:5ec4 with SMTP id sc3-20020a1709078a0300b0096f912e5ec4mr11425469ejc.16.1684839154706;
        Tue, 23 May 2023 03:52:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gr6-20020a170906e2c600b009658264076asm4247104ejb.45.2023.05.23.03.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:52:34 -0700 (PDT)
Message-ID: <7c075199-df5a-2136-8bed-b2be102ed02e@redhat.com>
Date:   Tue, 23 May 2023 12:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86: ISST: Remove 8 socket limit
Content-Language: en-US, nl
To:     Steve Wahl <steve.wahl@hpe.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230519160420.2588475-1-steve.wahl@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230519160420.2588475-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/23 18:04, Steve Wahl wrote:
> Stop restricting the PCI search to a range of PCI domains fed to
> pci_get_domain_bus_and_slot().  Instead, use for_each_pci_dev() and
> look at all PCI domains in one pass.
> 
> On systems with more than 8 sockets, this avoids error messages like
> "Information: Invalid level, Can't get TDP control information at
> specified levels on cpu 480" from the intel speed select utility.
> 
> Fixes: aa2ddd242572 ("platform/x86: ISST: Use numa node id for cpu pci dev mapping")
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  .../x86/intel/speed_select_if/isst_if_common.c       | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index e0572a29212e..02fe360a59c7 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -304,14 +304,13 @@ struct isst_if_pkg_info {
>  static struct isst_if_cpu_info *isst_cpu_info;
>  static struct isst_if_pkg_info *isst_pkg_info;
>  
> -#define ISST_MAX_PCI_DOMAINS	8
> -
>  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
>  {
>  	struct pci_dev *matched_pci_dev = NULL;
>  	struct pci_dev *pci_dev = NULL;
> +	struct pci_dev *_pci_dev = NULL;
>  	int no_matches = 0, pkg_id;
> -	int i, bus_number;
> +	int bus_number;
>  
>  	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
>  	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
> @@ -323,12 +322,11 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  	if (bus_number < 0)
>  		return NULL;
>  
> -	for (i = 0; i < ISST_MAX_PCI_DOMAINS; ++i) {
> -		struct pci_dev *_pci_dev;
> +	for_each_pci_dev(_pci_dev) {
>  		int node;
>  
> -		_pci_dev = pci_get_domain_bus_and_slot(i, bus_number, PCI_DEVFN(dev, fn));
> -		if (!_pci_dev)
> +		if (_pci_dev->bus->number != bus_number ||
> +		    _pci_dev->devfn != PCI_DEVFN(dev, fn))
>  			continue;
>  
>  		++no_matches;

