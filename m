Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8392B6CF677
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjC2WiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjC2Wh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:37:59 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252E55BA1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680129468; x=1711665468;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8mC4BypXl60HzEDMOes6JdsHqZokNKJxPcubhfSExuE=;
  b=hEm6yDoSx8mE8kmT3PS9vDUNaJ5hN1FB+yFF4xxXUavBGjMoyfkpyVdi
   tt65GrD4pd0Riz/+gOrbeObXnA/VYFJlEpzDYG1cw8X+jT5n++QASaSuN
   G8auaqyhuhl24cFqKB40x3z+JIqoAVbtpGayMoUWyA6TdfF2O8LV2M8L6
   NJEiKdzCh1pPkfIRCVF702PA+9FBBTSA5iisBuIV0TdDlqhRzrEGVso27
   AU8CY+RkAqdg12ZZSr4+okyuzOBjtpr3cBEMLix0BJAazUyVKUnYYin+d
   t0NyfguUQ0x1kn/hk221/c7q/4ja04j9JQdzgLFzLMFJON8w6MBauY3Qn
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226645314"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 06:35:01 +0800
IronPort-SDR: 95+wcyMWSzmTUlEtt3CdC9dJY+Jb4aZaM8s8lYMH+KmW2pkbCCoJ2QPqS7Y5KpGIYZOrPialYU
 pbc/8P7Up0n11+swUVBRkgtR9/BG69sO43ILH22DoayMuXFjXeyAGCWiCBQTT6DE1JYlqRJUZj
 00dLbiyjTmsJIdaw49BWWWzkwfsaBT64/r236yLfe/3HTcwtpAgLRQFFrFKMXl2Tkv6BbQLuBW
 pK+MNPu8rmUP37vxKyJ/JDuoaRNrBTT/iKDF/DBPmtEo8BX1AlCsloKYd59hJ2NTrHVcgsYnmZ
 xnM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 14:45:29 -0700
IronPort-SDR: w502YDi4NZqmozkMtFwhxTOmAsppPf0o7qp5vsMTh4Jmah7YDhE/d1sZ0TBrDUmvnyN68QTnFJ
 5Z6O+QZARXf8Y/nRMC0zIiWzej5TepQ2iN4fjjgjc8pg5/0tD74mjzz8VvBaki+q2gNvUGf4RD
 strxITdP1DjddmW/T35A5Nj2CdbSEcDEjnFeXX+6CYQP+Ov72azH8WKGw2ZVqLHtEmUqKLUjul
 Zxapd5sr2+bqZZ3FdoBEF5ffAzmPX1Kfwk+e+prEzlBz8yFu2UG5BJQHEP3OjlWofLIw+GbUuQ
 fzo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:35:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn1Zs1k75z1RtVq
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:35:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680129300; x=1682721301; bh=8mC4BypXl60HzEDMOes6JdsHqZokNKJxPcu
        bhfSExuE=; b=Zok4WYhcroENZvLPiiffuiL0wIhaaRMSE93p6mIUiG5P1+ftd2L
        q1g4BSW3yDCKYTtjxpyxP4yTyI5aihR+osGu3NHW33Fq3jncg3Qe7xNY4F/zwHCv
        etW1Nmc+YdHa6MKI4hd5xELhEGqsNDzfy7V+nuAUqZ9fc7RzMMfrtfJiNcSB4ANF
        pv7W16xNgr9XsLPJlP+2wNhoirGRaSfwNKtWLeK1SbCOjj5Lw5yzhhURWBT08bOc
        VuNZw5622X4vF6VjgAxro3fJgQJCUlPlSKztiYuxIJWi6gMTBHsKGitpZ4T4QUfn
        usPw+D9cS59VkGHy8R3Zh6mURJpGmFM4MSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gc_7azQUhaWY for <linux-kernel@vger.kernel.org>;
        Wed, 29 Mar 2023 15:35:00 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn1Zq4BbJz1RtVm;
        Wed, 29 Mar 2023 15:34:59 -0700 (PDT)
Message-ID: <18c3fbb4-59db-d508-ddd6-080cc8944b39@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 07:34:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Multiple undefined configuration options are dependent in Kconfig
 under the v6.3-rc4 drivers directory
Content-Language: en-US
To:     =?UTF-8?B?5a2Z5rui?= <sunying@nj.iscas.ac.cn>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org
References: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 16:52, =E5=AD=99=E6=BB=A2 wrote:
> It has been discovered that the following configuration options are und=
efined in the current latest version, v6.3-rc4, yet they are being relied=
 upon by other configuration options in multiple Kconfig files:
>=20
> MIPS_BAIKAL_T1 is undefined, used as a 'depends on' condition in multip=
le files such as drivers/ata/Kconfig, drivers/hwmon/Kconfig, drivers/bus/=
Kconfig, and drivers/memory/Kconfig.
> MFD_MAX597X is undefined, used as a 'depends on' condition in Kconfig f=
ile drivers/regulator/Kconfig.
> MFD_SM5703 is undefined, used as a 'depends on' condition in Kconfig fi=
le drivers/regulator/Kconfig.
> ARCH_THUNDERBAY is undefined, used as a 'depends on' condition in Kconf=
ig files drivers/pinctrl/Kconfig and drivers/phy/intel/Kconfig.
> ARCH_BCM4908 is undefined, used as a 'depends on' condition in Kconfig =
file drivers/leds/blink/Kconfig.
> MFD_TN48M_CPLD is undefined, used as a 'depends on' condition in Kconfi=
g files drivers/gpio/Kconfig and drivers/reset/Kconfig.=20
> USB_HSIC_USB3613 is undefined, used as a 'depends on' condition in driv=
ers/staging/greybus/Kconfig and drivers/staging/greybus/arche-platform.c.
>=20
> If these 7 configuration options are deprecated, it is recommended to r=
emove the dependencies on them in the Kconfig files.=20
> If they are still useful, it is recommended to define them.

+ linux-arm & linux-mips

What about you send patches to fix this ?

>=20
>=20
> Best regards,
> Ying Sun
> Pengpeng Hou
> Yanjie Ren

--=20
Damien Le Moal
Western Digital Research

