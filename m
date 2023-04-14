Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CCC6E1A98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDNDFQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Apr 2023 23:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDNDFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:05:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70722D71;
        Thu, 13 Apr 2023 20:05:10 -0700 (PDT)
X-UUID: a20525fd3f7a4a9d8bdc8283260ed39b-20230414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6778530b-50ce-46df-ad3e-2a8e9f0d50de,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-9
X-CID-INFO: VERSION:1.1.22,REQID:6778530b-50ce-46df-ad3e-2a8e9f0d50de,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-9
X-CID-META: VersionHash:120426c,CLOUDID:6d27ebea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230414004334KO0NTOQ6,BulkQuantity:3,Recheck:0,SF:19|45|24|17|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a20525fd3f7a4a9d8bdc8283260ed39b-20230414
X-User: zenghao@kylinos.cn
Received: from [172.20.12.253] [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1175297632; Fri, 14 Apr 2023 11:04:59 +0800
Message-ID: <d0420253c27c017d7617abcb75d900c82b68eda5.camel@kylinos.cn>
Subject: Re: [PATCH] cpupower:Fix resource leaks in sysfs_get_enabled()
From:   Hao Zeng <zenghao@kylinos.cn>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Apr 2023 11:04:47 +0800
In-Reply-To: <4ed23224-f418-3751-bf60-138a8b972d6c@linuxfoundation.org>
References: <20230413044602.3221453-1-zenghao@kylinos.cn>
         <4ed23224-f418-3751-bf60-138a8b972d6c@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Shuah
  Thank you for taking the time to reply to my email. 

On Thu, 2023-04-13 at 10:43 -0600, Shuah Khan wrote:
> On 4/12/23 22:46, Hao Zeng wrote:
> > The sysfs_get_enabled() opened file processor not closed,
> > may cause a file handle leak.
> > 
> 
> Please add information how you found this problem?
> 
> > Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> > ---
> >   tools/power/cpupower/lib/powercap.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/power/cpupower/lib/powercap.c
> > b/tools/power/cpupower/lib/powercap.c
> > index 0ce29ee4c2e4..a39ee1c89679 100644
> > --- a/tools/power/cpupower/lib/powercap.c
> > +++ b/tools/power/cpupower/lib/powercap.c
> > @@ -51,7 +51,7 @@ static int sysfs_get_enabled(char *path, int
> > *mode)
> >                 close(fd);
> >                 return -1;
> >         }> -
> > +       close(fd);
> 
> The error path logic can be simplified with a goto to
> to handle the error path to close the file and return.
> 
> >         if (yes_no == '1') {
> >                 *mode = 1;
> >                 return 0;
> 
> This path that returns 0 can be simplified as well to do
> return just once, after error path handling is done with
> a goto.
  Ok, I will provide V2
> 
> Please send me v2 with the changes above with information
> on how you found the problem.
> 
  I didn't find this problem by testing, just by reading the code

> thanks,
> -- Shuah
> 
> thanks,
> -- Shuah

