Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974677185D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjEaPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjEaPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:12:45 -0400
X-Greylist: delayed 131973 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 08:12:37 PDT
Received: from smtp45.i.mail.ru (smtp45.i.mail.ru [95.163.41.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BAF98;
        Wed, 31 May 2023 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=B0l+XTA5FGlPVTPUKIvg8UhwhNLqm34Y1pLjTr83bQM=;
        t=1685545958;x=1685635958; 
        b=Y3lLT2cO/HAhkKPnVmkRwiobUl/82Guj6g1oDUVLvnSmBe5kT8vfYZO8ZMk+HFq7bG2w1+9U4XZywJT6Ai41Au96JAhz8yKRogz1K3uWwEwRKcRelKK/P7eVFZipXRBahUP753dispGSRurywpqhCv5Liw2O5ovLB7xzgk1tFhk26N0yMvUHhqSSUKr7eCZGub1i0DqSBST7ML2yzq/1nD+tbkZGaY7Mq22qFtIdcfq5MtXmXow+1EYBwDwmQn1dGEQCB9UvVUE/GRVLdP1ycYVivaFo9z6inFtMu11S3ZlnVH+mXTZYpCeWfVPloSmgo2+kiyDYzz1BTbJ7ggv+og==;
Received: by smtp45.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
        id 1q4NV3-00DwZL-VZ; Wed, 31 May 2023 18:12:34 +0300
Message-ID: <35224f5b-cc66-ec27-7477-e9f98e7a5279@mail.ru>
Date:   Wed, 31 May 2023 18:12:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5.10 1/1] ovl: fail on invalid uid/gid mapping at copy up
Content-Language: ru
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20230530022917.18574-1-listdansp@mail.ru>
 <20230530022917.18574-2-listdansp@mail.ru>
 <CAOQ4uxgCizoAT1fWLKy6hytdhBiCwV0nSwkqzyVckozx5EACPA@mail.gmail.com>
From:   listdansp <listdansp@mail.ru>
In-Reply-To: <CAOQ4uxgCizoAT1fWLKy6hytdhBiCwV0nSwkqzyVckozx5EACPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp45.i.mail.ru; auth=pass smtp.auth=listdansp@mail.ru smtp.mailfrom=listdansp@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9FA9FE7958A526B7749C3D014EB2503E6839C1F944BEC2EA800894C459B0CD1B98F06A9CF50DFA013A8FB064D0C686CF76B0A0FE30BB0F3737B820C60925959D8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE743A67C3F703598BFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566E73BB9F70E9C8FAC9D0E474CA61CF5D6DB63F1BD2D50B66BA471835C12D1D977725E5C173C3A84C31E02C13459908652117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF15B380B5B570BCA9BA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C0329BA3038C0950A5D36D5E8D9A59859A8B6F4CAD2F895B8664376E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CE1AEB6AF2DA18B6243847C11F186F3C59DAA53EE0834AAEE
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D346B1FF97F6D0959A27DD7739A9D673168A929A171D74DE76F24C0DC8BA2554B2712BB58559AB791D01D7E09C32AA3244CA20D0A9534768D155C79BAEE451C3FE163871F383B54D9B37F5F07B4909EF5025DA084F8E80FEBD3D42CA810AD4FA7D0A8069D772E6E5B8583DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiEKym4lkdssspREoQkZFiQ==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7B45B19515236DF9B1A073B805C7F8A3FF97F17C85D3F6D89F7E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> From: Miklos Szeredi <mszeredi@redhat.com>
>>
>> commit  4f11ada10d0ad3fd53e2bd67806351de63a4f9c3 upstream.
>>
>> If st_uid/st_gid doesn't have a mapping in the mounter's user_ns, then
>> copy-up should fail, just like it would fail if the mounter task was doing
>> the copy using "cp -a".
>>
>> There's a corner case where the "cp -a" would succeed but copy up fail: if
>> there's a mapping of the invalid uid/gid (65534 by default) in the user
>> namespace.  This is because stat(2) will return this value if the mapping
>> doesn't exist in the current user_ns and "cp -a" will in turn be able to
>> create a file with this uid/gid.
>>
>> This behavior would be inconsistent with POSIX ACL's, which return -1 for
>> invalid uid/gid which result in a failed copy.
>>
>> For consistency and simplicity fail the copy of the st_uid/st_gid are
>> invalid.
>>
>> Fixes: 459c7c565ac3 ("ovl: unprivieged mounts")
>> Cc: <stable@vger.kernel.org> # v5.11
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> Reviewed-by: Christian Brauner <brauner@kernel.org>
>> Reviewed-by: Seth Forshee <sforshee@kernel.org>
>> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
>> ---
>>   fs/overlayfs/copy_up.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>> index e466c58f9ec4..fd33abc0edc0 100644
>> --- a/fs/overlayfs/copy_up.c
>> +++ b/fs/overlayfs/copy_up.c
>> @@ -882,6 +882,10 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
>>          if (err)
>>                  return err;
>>
>> +       if (!kuid_has_mapping(current_user_ns(), ctx.stat.uid) ||
>> +           !kgid_has_mapping(current_user_ns(), ctx.stat.gid))
>> +               return -EOVERFLOW;
>> +
>>          ctx.metacopy = ovl_need_meta_copy_up(dentry, ctx.stat.mode, flags);
>>
>>          if (parent) {
>> --
>> 2.25.1
>>
> You are requesting to backport to kernel 5.10.y a fix to a bug that is tagged as
> introduced in 5.11 with overlayfs unprivileged mounts.
>
> IOW, in kernel 5.10, current_user_ns() would always be init_user_ns.
>
> Am I missing something?
>
> Thanks,
> Amir.
>
Sorry for this inconvientions, really this issue was introduced in 5.11

Danila

