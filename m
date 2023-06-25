Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB273D193
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjFYOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFYOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:55:55 -0400
X-Greylist: delayed 1607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 07:55:53 PDT
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97F1AB;
        Sun, 25 Jun 2023 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:
        Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description
        :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6M6xaQ+v+1UpTE495Uk3ukIIDlfS3Cd3SrCD2m/lK5U=; b=JoYGvF4lBRr4nxBIzMORb/cDtK
        nsoaPvs1wvT9Sr+KkJdWIrEBOTdMySye0uDSQLiP6DRSUREyvp+t1zz25iMvD6kZnXUJELRITvkat
        D+LmHZ1/YJHMiBQ6BEWGt9JYH3I+gir61jxvg7mcRaddY6Nlk7eXdftv0iaFoOpjqbeXsB145q7rM
        ZzAhTwHe3Rg4AEX+WBljFxjaxZvQYOTIVeF/SkueN1Y16aIbgV9eCQqZmSa8xIVlrF0YCeSBz67RT
        IUIMgqKs3/zy4g2mKFRKGKTnp8QZf6XMRdNUF0x599q09qWBooUilDv7gcCqoY2Rq6Fkp0CbvG0JH
        NQgh53dg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qDQjR-00Fu6J-5D; Sun, 25 Jun 2023 14:28:49 +0000
Date:   Sun, 25 Jun 2023 14:28:49 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     sfrench@samba.org, linkinjeon@kernel.org, shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Duplicate unicode tables in smb/cifs/jfs
Message-ID: <ZJhPIYSUzBpuqosh@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 14:18:16 up 98 days, 52 min,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  I just tripped over three sets of duplicated unicode tables and
wondered if anyone had tried to rationalise them:

  The pair of:
   ./fs/smb/server/uniupr.h
   ./fs/smb/client/cifs_uniupr.h

   are identical except for formatting.

./fs/jfs/jfs_uniupr.c,
  and I think this is the same with some change in variable name.

(I'm guessing the same thing is implemented in a bunch of
other places as well in a different way)

Would it make sense to swing fs/smb/server/uniupr.h up to
hmm, maybe fs/uniupr.h, remove any of the cifs_ prefixes
and then use the same include in all 3 places?

Maybe then later look at using some of the nls code?

Dave (who just tripped over this stuff)

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
