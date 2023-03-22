Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2586C5A84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCVXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjCVXg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:36:26 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0079F23866
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528182; x=1711064182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=09Qms904bOmUjhbXd6xEeHgGApY/+/dzqrMlIByjay8=;
  b=OVAWCztFaURfL6NFTRkca1kWyJjNCZ4u1abobf/5pFQMsQPakXd4A7yy
   nYNhbX5moDrDRSQHyczzqLjIOWL6vnEsu7ymhqtBVE//UZ0/2yWKv+rAA
   E0ORm2nbzl8XwUaPrOkHOov20/BAiCbYtzOJdmngfjtyjnIxbsLwkn07W
   adnGjSvhgpnt4VrycN4MEbt2Lb5ky9QkbKsoU4BSedfgmvQKGrQvCYfhd
   sxL/Co41anHHlNF20ML4V95elQWv7sn9ydh6uSBf1xTmA1o6v0iPIyc6F
   swqW0KVyC+lg+Q3ddiGuYxPKcGVScQxHZsNCjk7ECUx3GNCH4/9oBhz7H
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="226273293"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:36:20 +0800
IronPort-SDR: UhTOzdpMAeta+Sqe9+7+TRyM6fzj4V0C39k8i/cbbXJNI4a5Wbo1RAm3A1RQM9ms56EOdBcBec
 Yaf9YQIqwt3to2BvA3YQ4XRN1y9iRiBbLMhrtQtcAbXtbFIkl2v1xwxmwcnFeLGznS8uvk6J5h
 12ShCVKaPsVRJ3ayR4cb1O9++jaKqeX6FFoRg4jBrREVcqW7aRb0qH0Mx5oe2TRxw9XppoXZ1T
 nFfGNAE1zlG1Pv4OkW2ZgqnAF89Cu8DWiFkmw55RtY4M6zJvG6VpdukzJe/iBxmwDWtCMOpafg
 FEo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:46:57 -0700
IronPort-SDR: 81yaNgC+42TCtULAQA29698snSDnU5fUKdcLYsZFWD2osaqOOnRVU0zdKiR4VvXHJJxq8Ia6Ze
 UDd47dRnaJ4xB1tSTvdHm/dFp+6JPkHbTeFXRltZJ/uK9bfV6JBxddoRGZoLlFMsz5Kuv80orn
 oLoXvfuICRdVd/83x7reKxf5fYvDgPSzfxBOIqAKSB73tG3LRzM7uSC+9SDb5rhQe1c+DUnne7
 m23vG76D+/SVWrx9QIYHO6BbETHALr5/72GaoVZWUJQrC+eR3TehmYssRhfQZZYMS361uStzte
 TmY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:36:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlGr5s1sz1RtVp
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:36:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528180; x=1682120181; bh=09Qms904bOmUjhbXd6xEeHgGApY/+/dzqrM
        lIByjay8=; b=KtGmz/4s+WErFe0YDopct4p9SCgKWSBjkf/v0LXVqpvIE7Cp97I
        HwUjAw1+w7quI27Y62BMUUcCK0OV5tPUUdDtK6IQW8fE8UeEryVZvG4mnLJOydCl
        jenTd/nd2h43CSxEVZlySJHOJ7x1asdj830YIOjJOEtD5u8vPE9gkos7uXnOO/Yy
        iQQo2zQMMOy1TNql00nYf3eO4t7c2XJImsYGHPIwiWx518ull3cXfVg6Y2QzL0k4
        tNnUmeh1UKgneidCUOku6Z07zNSqNxWoerMSUfGkTFDaZISoL+x+2kAivAEYxnlo
        1KPMFAkGgyFT2yeOjFFTCzbLZLr4kYsZSWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NJ-zfcmxpslv for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:36:20 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlGq1qY2z1RtVn;
        Wed, 22 Mar 2023 16:36:19 -0700 (PDT)
Message-ID: <1ca2125b-0e05-0ae9-3921-9b397732bc9c@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:36:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 08/10] ocfs2: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-7-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-7-frank.li@vivo.com>
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

