Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A065DC88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbjADTGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjADTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:06:48 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF5A1EC76
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:06:47 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i10so14197708vsr.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuc1t3GCjPr8Qvi8osvaPxtbjLlqHtJ8PDSe2jKqbY8=;
        b=OMn07GMbt40/sRzzlZOpAV4j/QODzDcQuaxAqxdpQtEq+FIDbxEZV8+yQLHMPGGv+N
         F3DbEkQi7yTauSIOonSoXt0wVVqT8a9SQ09ZflxckrsdrWVbBsNd28GnT6wWS56RS+La
         VMs1hC6JueKKoxJjEd8OeMQMI0928TtlCrT4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuc1t3GCjPr8Qvi8osvaPxtbjLlqHtJ8PDSe2jKqbY8=;
        b=jxyeknvu436QkRVgeeG4Ql7Kl3Z7J4CsEYqQ2Zk2kZWlnn2in4D5MrkzWdaVueBXRa
         eCQhAHoAxuu0VmGzNfkBNrM9WRsGjZTe9EzQjERNfsAtvxOPfTBPtlbel0Gvn4uH/Ped
         3P7yKeAUdlMQX55L7+OFF0eCHBmJ/MBR4rkTWY60bNmBf+ubwVEzEFae/vvm4x7g+CKH
         oXQT7Cqtl/PxHRq01++WnIJtlswDwevM8eX8DLV4RPbzwpRk3xAelwCUN0j4a+NCayhY
         DlvXb3KgJYLmMDkGFjn5zHvd5k5c42P+hBSNiSprix5VJKIMPZK1XAkTBsPjQqk6YjXw
         SoAA==
X-Gm-Message-State: AFqh2kpdKcfmoIOxTZmX7g6Dgpb/oqVg8yTqeYH8Gy/tNuDLhoC4rrTb
        J1FE7G9h4Rul2UOOClmdyIOlg/AeXwiQJ/JG
X-Google-Smtp-Source: AMrXdXtFYxfd/OUcZn8em+RHeUFM5mG+wOCxP8rLonqoPZQhJ+ycAHos0/XkBX3XeKGji83ZhaAs9g==
X-Received: by 2002:a05:6102:41a9:b0:3b5:21db:3174 with SMTP id cd41-20020a05610241a900b003b521db3174mr30224552vsb.10.1672859206322;
        Wed, 04 Jan 2023 11:06:46 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id m14-20020ae9e70e000000b006e42a8e9f9bsm24118883qka.121.2023.01.04.11.06.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 11:06:45 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id k3so16741397qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:06:45 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr2222059qkg.594.1672859204997; Wed, 04
 Jan 2023 11:06:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dbce4e05f170f289@google.com> <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
In-Reply-To: <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Jan 2023 11:06:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
Message-ID: <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000acd0af05f174e254"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000acd0af05f174e254
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 4, 2023 at 6:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> My patch was a mechanical conversion from '/* panic? */'
> to 'WARN_ON()' to work around a compiler warning,
> and the previous code had been in there since the
> 2004 HFS rewrite by Roman Zippel.

Yeah. Looking at the code, the warning does make sense, in that the
code then does a

   hfs_bnode_write(...)

with the updated data, using the size of "struct hfs_cat_file", so
checking that the entry has that length does seem somewhat sensible.

At the same time, the HFS_IS_RSRC(inode) case in the same function
never had that "panic ?" thing, and obviously the two cases that *do*
have the check never actually did anything (since 2004, as you point
out - you have to go back to before the git days to even see any
development in this area).

> I know nothing about what this function actually does,
> so my best answer is that we could revert my patch
> and use pr_debug() instead of WARN_ON() for all of these.

Looks like this is syzbot just mounting a garbage image (or is it
actually some real hfs thing?)

I'm not sure a pr_debug() would even be appropriate. I think "return
-EIO" (but with a hfs_find_exit()) is likely the right answer. We've
done that in the past (see commit 8d824e69d9f3: "hfs: fix OOB Read in
__hfs_brec_find").

I suspect this code is basically all dead. From what I can tell, hfs
only gets updates for

 (a) syzbot reports

 (b) vfs interface changes

and the last real changes seem to have been by Ernesto A. Fern=C3=A1ndez
back in 2018.

Hmm. Looking at that code, we have another bug in there, introduced by
an earlier fix for a similar issue: commit 8d824e69d9f3 ("hfs: fix OOB
Read in __hfs_brec_find") added

+       if (HFS_I(main_inode)->cat_key.CName.len > HFS_NAMELEN)
+               return -EIO;

but it's after hfs_find_init(), so it should actually have done a
hfs_find_exit() to not leak memory.

So we should probably fix that too.

Something like this ENTIRELY UNTESTED patch?

Do we have anybody who looks at hfs?

                      Linus

--000000000000acd0af05f174e254
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lci14mid0>
X-Attachment-Id: f_lci14mid0

IGZzL2hmcy9pbm9kZS5jIHwgMTUgKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9oZnMvaW5vZGUu
YyBiL2ZzL2hmcy9pbm9kZS5jCmluZGV4IDljMzI5YTM2NWU3NS4uM2ExNTVjMWQ4MTBlIDEwMDY0
NAotLS0gYS9mcy9oZnMvaW5vZGUuYworKysgYi9mcy9oZnMvaW5vZGUuYwpAQCAtNDU4LDE1ICs0
NTgsMTYgQEAgaW50IGhmc193cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
d3JpdGViYWNrX2NvbnRyb2wgKndiYykKIAkJLyogcGFuaWM/ICovCiAJCXJldHVybiAtRUlPOwog
CisJcmVzID0gLUVJTzsKIAlpZiAoSEZTX0kobWFpbl9pbm9kZSktPmNhdF9rZXkuQ05hbWUubGVu
ID4gSEZTX05BTUVMRU4pCi0JCXJldHVybiAtRUlPOworCQlnb3RvIG91dDsKIAlmZC5zZWFyY2hf
a2V5LT5jYXQgPSBIRlNfSShtYWluX2lub2RlKS0+Y2F0X2tleTsKIAlpZiAoaGZzX2JyZWNfZmlu
ZCgmZmQpKQotCQkvKiBwYW5pYz8gKi8KIAkJZ290byBvdXQ7CiAKIAlpZiAoU19JU0RJUihtYWlu
X2lub2RlLT5pX21vZGUpKSB7Ci0JCVdBUk5fT04oZmQuZW50cnlsZW5ndGggPCBzaXplb2Yoc3Ry
dWN0IGhmc19jYXRfZGlyKSk7CisJCWlmIChmZC5lbnRyeWxlbmd0aCA8IHNpemVvZihzdHJ1Y3Qg
aGZzX2NhdF9kaXIpKQorCQkJZ290byBvdXQ7CiAJCWhmc19ibm9kZV9yZWFkKGZkLmJub2RlLCAm
cmVjLCBmZC5lbnRyeW9mZnNldCwKIAkJCSAgIHNpemVvZihzdHJ1Y3QgaGZzX2NhdF9kaXIpKTsK
IAkJaWYgKHJlYy50eXBlICE9IEhGU19DRFJfRElSIHx8CkBAIC00NzksNiArNDgwLDggQEAgaW50
IGhmc193cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qgd3JpdGViYWNrX2Nv
bnRyb2wgKndiYykKIAkJaGZzX2Jub2RlX3dyaXRlKGZkLmJub2RlLCAmcmVjLCBmZC5lbnRyeW9m
ZnNldCwKIAkJCSAgICBzaXplb2Yoc3RydWN0IGhmc19jYXRfZGlyKSk7CiAJfSBlbHNlIGlmIChI
RlNfSVNfUlNSQyhpbm9kZSkpIHsKKwkJaWYgKGZkLmVudHJ5bGVuZ3RoIDwgc2l6ZW9mKHN0cnVj
dCBoZnNfY2F0X2ZpbGUpKQorCQkJZ290byBvdXQ7CiAJCWhmc19ibm9kZV9yZWFkKGZkLmJub2Rl
LCAmcmVjLCBmZC5lbnRyeW9mZnNldCwKIAkJCSAgICAgICBzaXplb2Yoc3RydWN0IGhmc19jYXRf
ZmlsZSkpOwogCQloZnNfaW5vZGVfd3JpdGVfZm9yayhpbm9kZSwgcmVjLmZpbGUuUkV4dFJlYywK
QEAgLTQ4Niw3ICs0ODksOCBAQCBpbnQgaGZzX3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCB3cml0ZWJhY2tfY29udHJvbCAqd2JjKQogCQloZnNfYm5vZGVfd3JpdGUoZmQu
Ym5vZGUsICZyZWMsIGZkLmVudHJ5b2Zmc2V0LAogCQkJCXNpemVvZihzdHJ1Y3QgaGZzX2NhdF9m
aWxlKSk7CiAJfSBlbHNlIHsKLQkJV0FSTl9PTihmZC5lbnRyeWxlbmd0aCA8IHNpemVvZihzdHJ1
Y3QgaGZzX2NhdF9maWxlKSk7CisJCWlmIChmZC5lbnRyeWxlbmd0aCA8IHNpemVvZihzdHJ1Y3Qg
aGZzX2NhdF9maWxlKSkKKwkJCWdvdG8gb3V0OwogCQloZnNfYm5vZGVfcmVhZChmZC5ibm9kZSwg
JnJlYywgZmQuZW50cnlvZmZzZXQsCiAJCQkgICBzaXplb2Yoc3RydWN0IGhmc19jYXRfZmlsZSkp
OwogCQlpZiAocmVjLnR5cGUgIT0gSEZTX0NEUl9GSUwgfHwKQEAgLTUwMyw5ICs1MDcsMTAgQEAg
aW50IGhmc193cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qgd3JpdGViYWNr
X2NvbnRyb2wgKndiYykKIAkJaGZzX2Jub2RlX3dyaXRlKGZkLmJub2RlLCAmcmVjLCBmZC5lbnRy
eW9mZnNldCwKIAkJCSAgICBzaXplb2Yoc3RydWN0IGhmc19jYXRfZmlsZSkpOwogCX0KKwlyZXMg
PSAwOwogb3V0OgogCWhmc19maW5kX2V4aXQoJmZkKTsKLQlyZXR1cm4gMDsKKwlyZXR1cm4gcmVz
OwogfQogCiBzdGF0aWMgc3RydWN0IGRlbnRyeSAqaGZzX2ZpbGVfbG9va3VwKHN0cnVjdCBpbm9k
ZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksCg==
--000000000000acd0af05f174e254--
