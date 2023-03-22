Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE76C5A85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCVXgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCVXgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:36:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D5234D9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528202; x=1711064202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=09Qms904bOmUjhbXd6xEeHgGApY/+/dzqrMlIByjay8=;
  b=bTRR3c6Gb7SpsBAb+9DpH8jd/O+tGHIQU2hje+pnK1cDirUi40/tJjwx
   3sZpqGr5a5n2LnNWpXyBdOR8vLN1qMnO0I3JAm07VCDiXGAjUN8qDT4hc
   zgS6uxprdf3+NBOy94JnZ8/gElKsU9Nx36XzjNcBUxk/jjFsOk4RKUsl2
   AMUrgYrqQV5JnRsqcuLQ6iA9cD1e7u6yfSp4ucCBMbRyJr3SJLDRnEcic
   s/ELe0EKcILdBPgieuyBagn2FBCQd7fAOM2MvBoYl3X7atcQTycsfhaJK
   FRjOBCrJnlbkCKlP164ZeBKFg3ogJwSxJJUqPHDGAgTrjrkkiwQjlbDBI
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224559510"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:36:42 +0800
IronPort-SDR: 2jBLomWr0oE253REMpQEWMIX9fLYVcY59IwbHB95gTI+kOXX4mLINUyTlVoSWR55Ect5lBG7j8
 mGGg6DpKMkxdX+TnCeQjCNXlZKJ5jtIlYQYNYXNYxYs1gm3FARPkp6nmpdPMaTv6002koEeqAU
 NKqxA6N7SwkAGjwF+LDlW6n+gVERKuGYOXSCCZUdcHXYxEFCR5l50wx2M67Sx5qJTN7GgSsW/n
 cMwzbOhhhpsK19tCp2eiKt9dPyuhQJpzb8PNBT+hm9WU+z1BXqV+hfP/M/roViBL0xH0nEjNm9
 ZtE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:47:18 -0700
IronPort-SDR: oVYpvx7VbBxjYDWQIRm5QocrYe5vWzUnP62J7lev44v8LTYU/2BVciujy4GWalbaILnhDejbkt
 5pyl7KRdt6/SB8uYXTwjPIWNoBEgVGsKTVob+sAO6g/U+8tK/2ypTiJ2EJQOcVOEgWvL15WoJs
 skeE1I7nf0GLO3Tmam6/e5TPsW8S8CBjZ0IZF1fZyCFKCdQRYQP0KrNjRVGDIRhx39HzMp44/n
 Mx7IMaK6EsGho6EczA/SY9FURshRS/hlU050Pn7XO78FMxa/VBkiWffYYeoOEaYHBjefitM/Po
 ZLI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:36:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlHG3Vj1z1RtVp
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:36:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528202; x=1682120203; bh=09Qms904bOmUjhbXd6xEeHgGApY/+/dzqrM
        lIByjay8=; b=MFws7Jvfl7rAxhhctrUR4tO/8eRHlWd8P+oSYG32AUDddxyfSEc
        iSeE+t8PU8Fix6ELXo9q06R/bS/0ZWxsrcg3MthEwF/ffcWJeacBI9MILMUBGXna
        dEYp2SW9K3xetu6X0VUPD1jsnFy5NoGefpCyAL8NcNNMNTJGo4oxNXBGUxp01/tP
        ek4NR8J+Z6CyJ+MSXn5TPxJ5GLMRsiayTE7QrC/Iy+Zc8mkXnGPzWcjHte84q22g
        ZekOb9i4YY+JzzHVZAvY/2gsy3z378kYGQfC7ASI/3qpR93hMVQ0mKYcnNT94v2i
        wK6t93C3GlrbR5rb0J8MUbydpSmxuWP985A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AcN4M5hV408n for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:36:42 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlHF0mbwz1RtVm;
        Wed, 22 Mar 2023 16:36:40 -0700 (PDT)
Message-ID: <5efc95e3-8a9b-49bd-8532-ec79a37b1697@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:36:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/10] nfs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-8-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-8-frank.li@vivo.com>
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

