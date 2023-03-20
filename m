Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59C6C0990
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCTEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCTEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:08:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0FEF99
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 21:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679285337; x=1710821337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f0RzrlZk36B8QlnIxOLMByV1TWNDOIMn6+7Rb8kJGp8=;
  b=nrxkh5QuMkBIeNyPGj152fgL0jPzr8hWcWECPgN05dS+ZQ5N9lpA4vWU
   fotQtzhi4nGp3G0nTbrQE+rejuoh4lWKWDKI5w7wbYeaPAFzkqF3ZRIA3
   7KW8hwPXLtqg6Y5J3v8ma2ue4dEKi/NWvPY3v+jEGpgB7LwrfLpHI7rrn
   7dFAN11f+YjBfv1T7hcwIWR/wB0iZy6ACrJmnG6U4gWiT65i3ttLRRJNh
   Du8RGx+4aS1+382KyLzEkTqt/NFhnM1whrUSx4mmViepuWaTvfQW9o7hS
   wS5xYOwBLXtVjxT21VCZCVM8zXI5/cDjMw/A6tH2T+zVrb/LezX7n/aQv
   g==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="330416227"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 12:08:52 +0800
IronPort-SDR: r1K2Y0vTA2PWjkYr+K87HUZWdG0Lrpn588KaqHJHVmnEpcc++NEca62RCwjlzzMg01nlz9VEG1
 jJG15dv5hOtKHy3kccHJZNEyVZUIkUtpIQuAYHoAk2WjZVW39emAaIR/iqADLkfWp7Oi3UIrJh
 Mj8JRnTC2yvM4nrHGV0C8ediCA7Fwxf6uYO2N6aR3h7f70lc/bdlT4AFecszSwMLC+9j3+e3ah
 sKOotrht8F3QyCRvb9Bw/TLpZdoNZb8T9cF8K0xXnVUuiC2gHB1qiA3iL8Tzh+sJyXYo8RJbaq
 wYM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 20:19:33 -0700
IronPort-SDR: 4h8yJmDGgC2D4R0svuZbIorSGVe0EokgkAL0NvEOLsgsPhsEYvHlYT1UUy/faB5p37SUv/Je1+
 F94513aBQecEG38wP9oe0nRXn3LAHAakJdVNzjwMqpT1ak2Wr+eTNFaUIV7gKmGe77EEj2ILxo
 6DofiwxzOxnZTofypmwA0+JfFSXrUmWaZQazCKCK9zw5IJNDxp20Lzwkyk9r+zA6hIhtBAr2ML
 e1mLOMV7tCZVEQImPjsB4nmr/VFjwYEgQgY4qElBFykLlRkC9RnO8DUERPyolgw7lPM/p996Ua
 rx4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 21:08:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg1Sh3pBPz1RtVn
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 21:08:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679285331; x=1681877332; bh=f0RzrlZk36B8QlnIxOLMByV1TWNDOIMn6+7
        Rb8kJGp8=; b=esT6TiIT+uoup3kWnY3xrSB3cYopIRmWLNhiVbZ6b5Myup6B95z
        p61YIXMydR7cv+BOtazS96fyHYNv37OnHrWVo6KCl4jC5ieFCwmxLpn12eg4/ysM
        pS91jjTlyfK5IAAj0Q5zaqAOyizcA9mGTXR4Q9eq3vYIamyUJ8etCo+vOy9sjk7l
        p6COnj+QZSprV+wuLiGHG6enDxDehZbJdOfQd1HClGCeQ2lGXZdLd/Qb+7pT/ebA
        Y3GEWaET42Y/8pV3BDj2JZueEuXtNYDsemmR9wfaJ23SwWvVQpUoQVjpDABRoBk6
        y7rjMU3wwH/4BD2261pJ4P51bH/Uqaj+DNg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z0peFt-XeK-B for <linux-kernel@vger.kernel.org>;
        Sun, 19 Mar 2023 21:08:51 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg1SY32s6z1RtVm;
        Sun, 19 Mar 2023 21:08:45 -0700 (PDT)
Message-ID: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
Date:   Mon, 20 Mar 2023 13:08:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230320033436.71982-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230320033436.71982-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 12:34, Yangtao Li wrote:
> Hi all,
> 
> Out of consideration for minimizing disruption, I did not send the
> patchset to everyone. However, it seems that my consideration was
> unnecessary, so I CC'd everyone on the first patch. If you would
> like to see the entire patchset, you can access it at this address.
> 
> https://lore.kernel.org/lkml/20230319092641.41917-1-frank.li@vivo.com/

Hard to comment on patches with this. It is only 10 patches. So send everything
please.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research

