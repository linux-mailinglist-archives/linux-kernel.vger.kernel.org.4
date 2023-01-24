Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4A678CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjAXAL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAXAL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:11:56 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70057279AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674519111; x=1706055111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xy0S4tydBQLsREe4methXzx1qb/et0hP72ULQQwMdGo=;
  b=d/hk1e7xQJf5n8VnMoyQ4ClQ1RPftdVCPO4MLvuuy2ofFp9zhnhYrw/0
   Gj3DteWHoCyv3OGA59zZXs0MNzUlumHX64BySa7nZ8cORMyYvPwCuQ1z2
   WNdOt1MsDgPB0U0JDXhDG5XV52I7ZyDVHUB7ArgFCkIrPoDhh1gEIxxpj
   UAMv18vRlpptGBSCfs41aGKp4qwnLi6MruipKZULOMrv48t7sdPN+UwuV
   eQnUHaefPX8wMpZcBK5aHbFxDb1/68jnBT/UOhkouSlk9BUHFmd9/QrIX
   Gsnnj17Q+L7SCGbDxsx3f5FUmqmSoFegMrbUypG5aRJ0Dd49e68XLN01G
   g==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="221659156"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 08:11:50 +0800
IronPort-SDR: Hv9UMDcwUmUBxK/q74XzQ75qkGMpDct0T4BoZIGfI/6ZSgXAlvrRtl6hN6cjqpbbiKz3NhKdCp
 72+Actt4BtASNiV5IaLO8hy03uzC3aD0JuQll77GSpUO0ODke//Sc1fnrRWxCGxuZ6HR9MJYdE
 XTGan+pbYvmvsMftxyfT5dNTVgbTVvXfqgGxqgx5v1QehHSYU7uS1eh30RoO/5Onx30BxgVeaQ
 2WrsQXkSTEHVvcpay8k9JmQX+XkLQRutNNXtvpl8UY0k7Q90sC+Ya/OqL2XQNM4DZ45BD0fEsr
 GTI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 15:23:40 -0800
IronPort-SDR: 7q8Xz5OmvtaqdwMZ9PHLAuU9OAtFqBtUo4pZXq00Q8a9dxbX3RodRZnUGtoGlpVsixh709OweN
 3WsQStChopJYkvF9o3c7QWnza9YgcpImizUDeiYmAPhc3LVyUeL96a8e2FqkMUFbIRBM/SMU4I
 hRkcoOvTUB9wYTt9bcS1t14kbkdjV1XQYMfoPjf5qOQIGILoS87FUXIQUbc3eV5e/KIp01sd75
 2Euk1CxMRUIW/EWoU5qLZvJ9O375U1aR8Bg21hW9PQEGXM1ytKF7n/0yqhjnf6wwO/diene4Bt
 FoI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 16:11:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P16pZ5kKGz1Rwrq
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:11:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674519110; x=1677111111; bh=Xy0S4tydBQLsREe4methXzx1qb/et0hP72U
        LQQwMdGo=; b=jLiwz6zGhpz696NE03KG9wTsTl14PCK1gPlySp1FYS5efzxPlNC
        qdcBiawTFomwNFE6gzuFBCi3BzFiOLeZaRNk6Xwng+nVpwN7r5KDd3h+0P8NiPo5
        VR4pv1Y7Hk0wIfLK9JmlACy6r8Aoo55l/+T/ywDGnXG9Evus2JPx1JSZyX+DUQfE
        4uSGjO2vJcFIgvu0WueuilR0n8Z+XhuOB9J91HyK634zLFiOC/HhrkN/XzeTWfIf
        fCJxWOuIOPTmtnGOJTv8wTFdQl8J2p0Rfn78/LH/Lr3L90hK/M9bQBdNI+oZVTgB
        ft09hjaKX3Gu9dzk1VdQ9Gj2YxLvnW/fwog==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KlvBS_o5sosa for <linux-kernel@vger.kernel.org>;
        Mon, 23 Jan 2023 16:11:50 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P16pX6mrnz1RvLy;
        Mon, 23 Jan 2023 16:11:48 -0800 (PST)
Message-ID: <8871d62a-b87f-75d6-fb5d-d9811a3e5dae@opensource.wdc.com>
Date:   Tue, 24 Jan 2023 09:11:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: manual merge of the zonefs tree with the
 vfs-idmapping tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230124085951.59eb8da3@canb.auug.org.au>
 <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
 <20230124102535.1e21a533@canb.auug.org.au>
 <87958074-baa4-b6c9-da0c-d654e4009611@opensource.wdc.com>
 <20230124110745.5c9b78b0@oak.ozlabs.ibm.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230124110745.5c9b78b0@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 09:07, Stephen Rothwell wrote:
> Hi Damien,
> 
> On Tue, 24 Jan 2023 08:30:29 +0900 Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>>
>> OK. I think I will merge the 3 patches that create the conflict and rebase
>> the patches. I need that for retesting at least. But given the size of the
>> conflict resolution, I may push that as an update to my for-6.3/for-next
>> branch. Let me see...
>>
>>> Alternatively, just leave the fix up to Linus (but mention it to him
>>> when you send your pull requests).  
>>
>> Understood. Let me retest first :)
> 
> When I said "merge", I meant literally "git merge <some stable branch
> from the vfs-mapping tree that contains the conflicting commit>" not
> cherry pick the commits i.e. you would need to coordinate with
> Christian about having a common branch (or making sure that the part of
> his tree you pull in is immutable).

Yep, cherry picking did not work :)
I did a merge test and came up with the same resolution as you did. It
looks good. It looks big but is in fact fairly simple. I will keep it as
is and signal it to Linus when I send my PR.

But retesting everything to be sure there are no issues.

Christian,

Next time, when you touch an fs, please cc the maintainer for acks. I had
that zonefs series ready for a while and we could have coordinated for the
conflict...

-- 
Damien Le Moal
Western Digital Research

