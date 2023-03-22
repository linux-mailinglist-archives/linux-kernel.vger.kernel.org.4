Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589F6C5A88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCVXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCVXhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:37:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B7234FB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528222; x=1711064222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rNEfSER4swwikeY50PtiH1QfqYxcG1VPN0FLVwTfQCk=;
  b=oZF3h1WhPGP+p5mL2JyaEbZ2Lw7CBjdV5A/254WPjbYsj0QKeEAZ8v8l
   X6+kGPpfbOE3DZpNAxuyqLfqsoUOXPPVSAB0VbRbxzYcjKU4IUXSGyD0y
   5q7DKUbr3Q22pYETOzHJTh+KrkYpHstSzUmFWRoitelzA7GMxVLsJG+DP
   DrTdyl3q6Op/c1bI34uHuSidimckgBEE8ZeVw3e2XhyR8380XUDAsD5p8
   NshpWWAFUscJSj6lTknfOIlkiINpuH1v4/u9BZq+mG98+zCvjsT7qdved
   JEVzSlD1RmT8vn5hghC6vmPngY9qCEuyu9RIOut9gU1PlYbaVwSYn7pNx
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224559537"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:37:01 +0800
IronPort-SDR: NHFm/ZsQVGVfLrRAc4rNTG7tDJwWTnqhODzCkjfbqL3wyQHDkdKe5xsyftYl+gtUP4U/D9t5Wp
 S84l4o5tKQJzrG49Tnu7dJ5Ox6CBxplpUOlh9L0Y/DHa12Tum+N8wrkLBFcThZ4Q6B0vKONCdE
 Ngd0iiIHTdpQNrjLVivnYNDAztVszC7v8SsT6NS4Nw3p8YqUEE+pYd9lf8DG8f9YXaVicl+HyJ
 ao8p6RGWtdXo8JjXWJKipCkq84QaRyRefLWNH1aosxgLxSdel2/KfLrEBf4hnnNvLRyRgzZRPL
 sA8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:47:38 -0700
IronPort-SDR: r/PWC7zqAgFch+QsS5ldOy41qYeeoKXuuCWe1FxA2pzPhObgGArEFB7krjnq40BB7hqEhazLSj
 TRlwm/YKO7qnt/18ulU/0EW/9Xg2QQjRE+0GpjRsdv3cG5k63JSjujw1lVHigXpJQ/vjyLt3B5
 vde6x3h4SCBP4J/fV2EZm/uCwNpRfp0tX9E2r2ThLvk8eTq6ubY8NGknN6lQZfqbKyqP+axXbK
 Xm7kE9giZ1AINqG5EdupSsFgtPMuWRhiun9mILSuII+rkz+EV1858S2L1stJ1InPDVN4QLu3jz
 t5A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:37:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlHd5PGwz1RtVw
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:37:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528221; x=1682120222; bh=rNEfSER4swwikeY50PtiH1QfqYxcG1VPN0F
        LVwTfQCk=; b=gT5N7kqZT/kA++fyjWYaTTcnwsHIU+GxJKWEfPwzBiAuQVTWE/1
        /XSwnAsGDMRI/Y1Jhnkq1HUe07ZviACdSHwYBy3cPkogTD3aZzjZw6ZN5tHgpe9r
        rYmSGTTnjYGKPrZ9a/0zI/nDYVo83VcWkNqYbvWtD9gDfcaB5H7WHjvAP1w/VrrN
        nfP1vozO/wPTRIJQCGTxpM7ajlvBYy7MdKoeUoPGXS/c9SkgKFCicMwWBmhUsxmR
        1deI/MYdU9LPZjEUCSrqU5VLR4JGUe0MfWWt4ECMEUqLtwlqgFCm34sEU4T+mopP
        NIq5omYoOjp17FeDSPQj4xsIsoP7veSa97g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4CqoHFlxVvBA for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:37:01 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlHc1plZz1RtVm;
        Wed, 22 Mar 2023 16:37:00 -0700 (PDT)
Message-ID: <b81bd0d2-bf95-a3da-2fdf-a7d95600f370@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:36:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 10/10] nilfs2: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-9-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-9-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 01:59, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

