Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A346C5A78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCVXdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCVXdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:33:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA13212B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528021; x=1711064021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MH56pcFSkJPYr+IGjg0SEwtb90roDYAAh0io8KA4j4U=;
  b=AOMNk7s48oXcV/lvb+eZuIoeMXQ34FMTM64MnDLBZ4Fyxdl87ouS5/CC
   l51O5E7hOKR5rf27sUMifZj3x4DCJN+DBEcBpFPTdSBFXfeMVGoFIXHzd
   Oid8MHQ/XO2+8FQCW7L04lJkoj0/ht99lCSwBQTEbCLDsNkrLkwqOwtw2
   X9853H87Eo9ply0LNDOfk1czOmmc36tpdz7U1PaH4aj9N7tyF1kbOCvBi
   MObNihgh8bi8BHjpUsrJawuEKJMuSSn+8HBikFr1ITrFqFO77MvhpP7ob
   G04UcOvh4pe9T3ljfV/chlMuUTwGM/iiFY5cqqijigfSNDwKfZiHZN/yb
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="226084166"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:33:39 +0800
IronPort-SDR: uu0Dqjw4EQdzvlqzJ+WpsGEx4XU4S1qL+OBLc2hBEaYM7f0mtAf3aFgl1kBH2byYrIWW94gkYV
 4UqjAcQh4/SnujsUC4HEfH9r16U7LgP1nFsbBELkwfmfg+hTa+0v+8PZjhppSahWlf2ChFlTEJ
 jIVxBCt9vQ44QgdZL7pE+I+9n7MsRCpIiRbeXpOysB/7w/3RLm+dEkThgoLXvE1DIxADPzaWd8
 zjdUENINQ6BuBy10PUvzgjmnDUNQSvvgyV+hmdp/61TgMSndKwVxXGR++NLP3ME7aPi3kq/QTD
 ZVM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:49:56 -0700
IronPort-SDR: BsNT8WuGbaAtvd+9eqCWddu01a0o92GjGBqLb4djV9351KLwUuu+X08SLJJsteGCv06AXgJZfM
 1par4t9tCVkniMfwVwHH/JAjyTw04uo33LKT06zdRj9IJxWwm/BKL2pf6lKxmKptOxlGPFgJXp
 ezJzMPSHv2wd0WSDgw7Mt+RAhSAAH2h2da5T/jbOkofBx4p/PRHv6A3288TY9dDhtArRMp3EKl
 rOWrNstqDz3s5ewS1AfI3k3IqdHBd1N0I5//JqTmwqUiL3E22F1pvFLZDWg0dhx5V2MLBzoBux
 09U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:33:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlCk6Z2Yz1RtVv
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:33:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528018; x=1682120019; bh=MH56pcFSkJPYr+IGjg0SEwtb90roDYAAh0i
        o8KA4j4U=; b=lsOZKzyr8mqqr5xUx7uIgSjqJfaBO7rblgZod6RTwXifHlSAwz1
        4UJ3yufvjeP7FMVtoeBsdAu85G3yu6KZze281Lal71XhB7kNIGIoqef64mPlQdAg
        0djcxVCO1pL/Jmk7+gSb+pgBT3jVGZ9Cfrec4yXtepZB0a+lPTJP1v9KMnNmOUuY
        G55r5eX6c4LZrxZbrFTj1nhfwpzsm3JCS/xYWLXV8cN3WIKEw3dyNf4DSPnU64jE
        6HNCzo1IvHZMJzvX/Z/5TRcwVLql9KR7hLFO1VLr9Uo6xNULpH3Ewb1ppfCGXj1C
        uU9nCSuxmGq1IULB8b+7jQHFFpcVr4ACChw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dB8wrRo8tZOV for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:33:38 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlCj3CZbz1RtVm;
        Wed, 22 Mar 2023 16:33:37 -0700 (PDT)
Message-ID: <89dd308e-2140-921e-6c08-91bf7b1eee63@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:33:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/10] zonefs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-3-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-3-frank.li@vivo.com>
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

On 3/23/23 01:58, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

