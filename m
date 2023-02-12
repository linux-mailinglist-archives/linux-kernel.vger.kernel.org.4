Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CEF693B00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 00:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBLXJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBLXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:09:51 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE3D522
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 15:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676243390; x=1707779390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EIcynABI6eV7+ZrIO/d7OvBozPHAy0oWjn5B/BE+VHk=;
  b=aSpbcdboo3q/lBuQBOGyTMbbltboQuCY0rhe0zBs335Nic6onixJK0gN
   q5SL236dz8IOw4jK+BKxkfHN/n2Z06tOClRJ62wjGhtMIz9mIvNngfH1J
   Gfsih6M5yqmteXt4WNxHYAiHnFhbGo3T/UE0Bqb4DaibcCXenyFARkCIT
   T/QicQ6pMAz9UCWNuBVf6aCOiGnRbRUh7Wo19Oyo/GTuc5IopZkbVeQUf
   0iX+fATQWRHEGtdZv6l267iAXLfSkHmPZ1DnAukKiPLj8DJA8MT0mtEqP
   tq9ASmDpb5ZJbqVGcfGRKGapmRXO3SBT3oP90NSUvGsQMwx6WjlCz5rgN
   w==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="223155001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 07:09:48 +0800
IronPort-SDR: L/GnsmhHHk7aMogoYw5CAaCRUYno7e7G+bY6XNJfY5UEYnSENWscHWP7P5fX01JMV+U7bCuroW
 KCAk8HI4pDb3cL/0gqzZslohvS/gy74vOXtfmBbCMm4Y6mKPK0CUEUvGhcKXHDZIGoZMgNiH/n
 gkrlMh730OLpS4nk0EGEKIYQ5kWcLCms5vW8KeSpdo/GwWvhQ7XS+Ak7lUtSipV5dL5FTjgecA
 kVgF3FW9Et7UK8FlxBiMakTfuVNqFvbxbdcsC7jVMHuzrd8VOdM/u+QAgE9knT9qIL2qMZ+5Bh
 EZA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 14:26:59 -0800
IronPort-SDR: +153F3NSlpvMaaEjUq0uAaB4PyQ+RAdnTYLjECEzNZNHBND3m6WLTl/EfsBFWYqnsGg1K3g553
 /YRIXoZadLzQgUZ9/iehJREXpQeflQNn6f9xPjemAAjLs2dFMUXeMnDpqK6CnJeuAMBI9VI9Ut
 BLuXOERoKMyJPKaWNgSTYSqvg7PZ1notTa+O3AJzc32pLHbnDomdV0HS4WACxlrSVoCa/rT37R
 nxYk8j0U8517K/imDeUPH/UaicvzNcF5RUSBCq2lP/zNgOwfkU5bZlBG116EgBzJJoW3G2eA7+
 HxM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 15:09:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PFNTm4YnYz1RvTr
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 15:09:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676243388; x=1678835389; bh=EIcynABI6eV7+ZrIO/d7OvBozPHAy0oWjn5
        B/BE+VHk=; b=R3BdfjIlgGQd6D9DnacNqGwJd4/VNEAdS44OIRJlhLvnOxT+/Ne
        xX7judt+N4DV7p7eHk33DET9vvNqEljU3OOeP/xFEIX8LpxVht3BYL/QwfjtChct
        VfroetTFvrISrj0ajONeSld/flwekuPkfFwRddSUZIMJ+CrznO3Z0B3A/pv00UkF
        1vsEYblfQA9B54aUyaN4ntsCxPKqXBNTM6dsvEMq8TS/RgPb7EvrdkjTJVpNryKV
        mEYlyFNSSZvHKrUKYUqUuSO0PPZqCtgQAHTi71v9nQLFqiRDX17VKfoS/17ESEjM
        aV1gidLqN7vtS2lIdPUmJZZrMNSNI3scb6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xH6K7oR3g4gj for <linux-kernel@vger.kernel.org>;
        Sun, 12 Feb 2023 15:09:48 -0800 (PST)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PFNTl2p37z1RvLy;
        Sun, 12 Feb 2023 15:09:47 -0800 (PST)
Message-ID: <665f4223-8de2-a268-b072-f01b2b1317e5@opensource.wdc.com>
Date:   Mon, 13 Feb 2023 08:09:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] zonefs: make kobj_type structure constant
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 11:14, Thomas Wei=C3=9Fschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>=20
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied to for-6.3. Thanks !

--=20
Damien Le Moal
Western Digital Research

