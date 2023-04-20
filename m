Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37F6E8DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjDTJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDTJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:16:27 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 02:16:25 PDT
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D699;
        Thu, 20 Apr 2023 02:16:24 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Thu, 20 Apr 2023 11:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1681981567; bh=mlTANCmDo+Jtpjnm59UD3LG84AZcxPMr8iGEO/CopDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/CMoPzVCko6Z7jL3zNK7X/zn69XihFFHdr8E6bxN5EFgn+e5qdPVEQQtPkE68NBf
         EJeijtER7j+ccuefD9qLacG7IqV1Vn+Pq14DVXkn1w6TBZKhlS93Mpl2YxGUBBqi4r
         HDRUAYcQa59N2HLweFMt0jRqYDH3ITa1Byke0IGw=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id DCC3482294;
        Thu, 20 Apr 2023 11:06:06 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id CE72A180E99; Thu, 20 Apr 2023 11:06:06 +0200 (CEST)
Date:   Thu, 20 Apr 2023 11:06:06 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, dalevi@nvidia.com,
        Gal Pressman <gal@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar
 packages
Message-ID: <ZEEAfkOGyVs1KD5Z@buildd.core.avm.de>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-3-masahiroy@kernel.org>
 <20230407181223.GD1018455@dev-arch.thelio-3990X>
 <a42a2dc4-bcbc-7a19-b036-8722606a5eaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a42a2dc4-bcbc-7a19-b036-8722606a5eaf@gmail.com>
X-purgate-ID: 149429::1681981566-B3FD5C00-30EE84B8/0/0
X-purgate-type: clean
X-purgate-size: 2621
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:54:34AM +0300, Tariq Toukan wrote:
> 
> 
> On 07/04/2023 21:12, Nathan Chancellor wrote:
> > On Fri, Apr 07, 2023 at 07:16:29PM +0900, Masahiro Yamada wrote:
> > > Commit 05e96e96a315 ("kbuild: use git-archive for source package
> > > creation") split the compression as a separate step to factor out
> > > the common build rules.
> > > 
> > > With the previous commit, we got back to the situation where
> > > compressed source tarballs are created by a single rule.
> > > There is no reason to keep the separate compression rules.
> > > 
> > > Generate the comressed tar packages directly.
> > > 
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > 
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > 
> 
> Hi,
> 
> We started seeing the failure below in rc7.
> We narrowed it down to your patches:
> 
> 3c65a2704cdd kbuild: do not create intermediate *.tar for tar packages
> f8d94++c4e403c kbuild: do not create intermediate *.tar for source tarballs
> f6d8283549bc kbuild: merge cmd_archive_linux and cmd_archive_perf
> aa7d233f45b4 kbuild: give up untracked files for source package builds
> 
> Can you please take a look and advise?
> 
> Regards,
> Tariq
> 
> [root@c-237-113-200-203 linux]# make -j24 rpm-pkg
> sh ./scripts/package/mkspec >./kernel.spec
> rpmbuild  --target x86_64-linux -bs kernel.spec \
> --define='_smp_mflags %{nil}' --define='_sourcedir rpmbuild/SOURCES'
> --define='_srcrpmdir .'
> Building target platforms: x86_64-linux
> Building for target x86_64-linux
> Wrote: ./kernel-6.3.0_rc7+-1.src.rpm
> rpmbuild  --target x86_64-linux -rb kernel-6.3.0_rc7+-1.src.rpm \
> --define='_smp_mflags %{nil}'
> Installing kernel-6.3.0_rc7+-1.src.rpm
> Building target platforms: x86_64-linux
> Building for target x86_64-linux
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.yDFEga
> + umask 022
> + cd /root/rpmbuild/BUILD
> + cd /root/rpmbuild/BUILD
> + rm -rf linux
> + /usr/bin/gzip -dc /root/rpmbuild/SOURCES/linux.tar.gz
> + /usr/bin/tar -xof -
> + STATUS=0
> + '[' 0 -ne 0 ']'
> + cd linux
> /var/tmp/rpm-tmp.yDFEga: line 37: cd: linux: No such file or directory
> error: Bad exit status from /var/tmp/rpm-tmp.yDFEga (%prep)
> 
> 
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.yDFEga (%prep)
> make[1]: *** [scripts/Makefile.package:69: rpm-pkg] Error 1
> make: *** [Makefile:1656: rpm-pkg] Error 2

Thanks for the report.  It should/will be fixed with 
https://lore.kernel.org/linux-kbuild/20230419170424.78688-1-masahiroy@kernel.org/

Kind regards,
Nicolas
